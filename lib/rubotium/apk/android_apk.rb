require "tmpdir"
require "pp"
module Rubotium
  module Apk
    require "tmpdir"
    require "pp"
    class AndroidApk
      attr_accessor :results,:label,:labels,:icon,:icons,:package_name,:version_code,:version_name,:sdk_version,:target_sdk_version,:filepath
      def initialize(path_to_apk)
        @path = path_to_apk
        raise(Errno::ENOENT, "File does not exist") unless File.exist?(@path)
      end

      def package_name
        parsed_aapt['package']['name']
      end

      def icon

      end

      def results
        command = "aapt dump badging \"" + @path + "\" 2>&1"
        results = `#{command}`
        if $?.exitstatus != 0 or results.index("ERROR: dump failed")
          raise(RuntimeError, results)
        end
        @results ||= results
      end

      def parsed_aapt
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
