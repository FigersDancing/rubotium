module Rubotium
  module Adb
    module Commands
      class Command
        def initialize(device_serial)
          @device_serial = device_serial
        end

        def install(apk_path)
          execute(install_command(apk_path))
        end

        def uninstall(package_name)
          execute(uninstall_command(package_name))
        end

        def pull(files_glob)
          execute(pull_command(files_glob))
        end

        def shell(command)
          execute(shell_command(command))
        end

        def execute(command_to_run)
          puts "EXECUTING_COMMAND: #{adb_command} #{command_to_run.executable_command}"
          CMD.run_command(adb_command + " " + command_to_run.executable_command)
        end

        private
        attr_reader :device_serial

        def adb_command
          "adb -s #{device_serial} "
        end

        def install_command(apk_path)
          Rubotium::Adb::Commands::InstallCommand.new(apk_path)
        end

        def uninstall_command(package_name)
          Rubotium::Adb::Commands::UninstallCommand.new(package_name)
        end

        def pull_command(files_glob)
          Rubotium::Adb::Commands::PullCommand.new(files_glob)
        end

        def shell_command(command)
          Rubotium::Adb::Commands::ShellCommand.new(command)
        end
      end
    end
  end
end
