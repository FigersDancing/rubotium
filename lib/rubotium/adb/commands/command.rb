module Rubotium
  module Adb
    module Commands
      class Command
        def initialize(device_serial)
          @device_serial = device_serial
        end

        def clean_logcat
          execute(logcat_command(:clean => true))
        end

        def logcat
          execute(logcat_command(:dump => true))
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

        def push(local_glob, remote_dest)
          execute(push_command(local_glob, remote_dest))
        end

        def shell(command)
          execute(shell_command(command))
        end

        def execute(command_to_run)
          commands = command_to_run.executable_command
          puts "EXECUTING_COMMAND: #{adb_command} #{commands}"

          begin
            commands.each do |command|
              CMD.run_command(adb_command + ' ' + command)
            end
          rescue NoMethodError
            CMD.run_command(adb_command + ' ' + commands)
          end
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

        def push_command(local_glob, remote_dest)
          Rubotium::Adb::Commands::PushCommand.new(local_glob, remote_dest)
        end

        def shell_command(command)
          Rubotium::Adb::Commands::ShellCommand.new(command)
        end

        def logcat_command(options = {})
          Rubotium::Adb::Commands::LogcatCommand.new(options)
        end
      end
    end
  end
end
