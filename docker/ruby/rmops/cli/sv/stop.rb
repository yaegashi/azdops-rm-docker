class RMOps::CLI::SV
  desc 'stop', 'Service stop'
  def stop(*args)
    run "sv stop #{arg_srvs(args).files.join(' ')}"
  end
end
