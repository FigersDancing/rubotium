require 'dex2jar'
module Rubotium
  module Apk
    class Converter
      def initialize(apk_path, output_path)
        @apk_path     = apk_path
        @output_path  = output_path
      end

      def convert_to_jar
        Dex2jar.execute("-f -o #{output_path}", [apk_path])
      end

      private
      attr_reader :apk_path, :output_path

      def file_exists?
        File.exist? apk_path
      end
    end
  end
end