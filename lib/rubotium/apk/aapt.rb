module Rubotium
  module Apk
    class Aapt
      def dump(path)
        CMD.run_command("aapt dump badging \"" + path + "\" 2>&1")
      end
    end
  end
end
