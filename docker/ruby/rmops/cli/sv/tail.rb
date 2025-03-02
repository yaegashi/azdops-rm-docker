class RMOps::CLI::SV
  desc 'tail [OPTIONS] [SERVICES]', 'Service tail logs'
  def tail(*args)
    opts = arg_opts(args)
    logs = arg_srvs(args).files('log/current')
    begin
      run "tail #{(opts + logs).join(' ')}", exception: false
    rescue Interrupt
      puts
    end
  end
end
