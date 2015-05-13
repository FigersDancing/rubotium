module Rubotium
  class LogWritter
    def save_to_file(file_name, log)
      File.open("results/logs/#{file_name}.log", 'w+') do |file|
        file.write log
      end
    end
  end
end
