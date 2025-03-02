class RMOps::CLI::SV
  desc 'start', 'Service start'
  def start(*args)
    run "sv start #{arg_srvs(args).files.join(' ')}"
  end
end
