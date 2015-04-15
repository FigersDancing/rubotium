require "tmpdir"
require "pp"
module Rubotium
  module Apk
    require "tmpdir"
    require "pp"
    class AndroidApk
      attr_reader :aapt
      attr_accessor :results,:label,:labels,:icon,:icons,:package_name,:version_code,:version_name,:sdk_version,:target_sdk_version,:filepath
      def initialize(aapt = Aapt.new, path_to_apk)
        @aapt = aapt
        @path = path_to_apk
        raise(Errno::ENOENT, "File does not exist") unless File.exist?(@path)
      end

      def package_name
        if parsed_aapt['package'].nil?
          raise RuntimeError.new('ERROR: dump failed because no AndroidManifest.xml found')
        end
        parsed_aapt['package']['name']
      end

      def icon

      end

      def results
        @results ||= aapt.dump(@path)
        if @results.status_code != 0
          raise(RuntimeError, @results.result)
        end
        @results
      end

      def parsed_aapt
        vars = Hash.new
        results.result.split("\n").each do |line|
          key, value = _parse_line(line)
          next if key.nil?
          if vars.key?(key)
            if (vars[key].is_a?(Hash) and value.is_a?(Hash))
              vars[key].merge(value)
            else
              vars[key] = [vars[key]] unless (vars[key].is_a?(Array))
              if (value.is_a?(Array))
                vars[key].concat(value)
              else
                vars[key].push(value)
              end
            end
          else
            vars[key] = value.nil? ? nil :
              (value.is_a?(Hash) ? value :
                (value.length > 1 ? value : value[0]))
          end
        end
        return vars
      end

      def _parse_values(str)
        return nil if str.nil?
        if str.index("='")
          # key-value hash
          vars = Hash[str.scan(/(\S+)='((?:\\'|[^'])*)'/)]
          vars.each_value {|v| v.gsub(/\\'/, "'")}
        else
          # values array
          vars = str.scan(/'((?:\\'|[^'])*)'/).map{|v| v[0].gsub(/\\'/, "'")}
        end
        return vars
      end

      def _parse_line(line)
        return nil if line.nil?
        info = line.split(":", 2)
        return info[0], _parse_values( info[1] )
      end

      def self._parse_aapt(results)
        vars = Hash.new
        results.split("\n").each do |line|
          key, value = _parse_line(line)
          next if key.nil?
          if vars.key?(key)
            if (vars[key].is_a?(Hash) and value.is_a?(Hash))
              vars[key].merge(value)
            else
              vars[key] = [vars[key]] unless (vars[key].is_a?(Array))
              if (value.is_a?(Array))
                vars[key].concat(value)
              else
                vars[key].push(value)
              end
            end
          else
            vars[key] = value.nil? ? nil :
              (value.is_a?(Hash) ? value :
                (value.length > 1 ? value : value[0]))
          end
        end
        return vars
      end
    end

  end
end
