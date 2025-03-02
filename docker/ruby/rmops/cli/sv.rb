class RMOps::CLI::SV < Thor
  include RMOps::Consts
  include RMOps::Logger
  include RMOps::Utils

  no_commands do
    def arg_opts(args)
      args.select { |a| a.start_with?('-') }
    end

    def arg_srvs(args)
      srvs = args.reject { |a| a.start_with?('-') }
      srvs = %w(rails sidekiq) if srvs.empty?
      class << srvs
        def files(*args)
          map { |s| File.join(RMOps::Consts::SERVICE_DIR, s, *args) }
        end
      end
      srvs
    end
  end
end

require_relative 'sv/restart'
require_relative 'sv/start'
require_relative 'sv/status'
require_relative 'sv/stop'
require_relative 'sv/tail'

class RMOps::CLI
  desc 'sv', "Manage services in #{SERVICE_DIR}"
  subcommand 'sv', RMOps::CLI::SV
end
