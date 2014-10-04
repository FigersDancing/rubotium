require 'ostruct'
module Rubotium
  module Adb
    module Parsers
      class Procrank

        DEFAULT_RESULT = [0, 0, 0, 0, 0, '']

        def initialize(result)
          @result = result
        end

        def parse
          OpenStruct.new(:pid => pid, :vss => vss, :rss => rss, :pss => pss, :uss => uss, :cmdline => cmdline)
        end

        private

        attr_reader :result
        def pid
          split.first.to_i
        end

        def vss
          split[1].to_i
        end

        def rss
          split[2].to_i
        end

        def pss
          split[3].to_i
        end

        def uss
          split[4].to_i
        end

        def cmdline
          split[-1]
        end

        def split
          @split ||= result.empty? ? DEFAULT_RESULT : result.split
        end

      end
    end
  end
end
