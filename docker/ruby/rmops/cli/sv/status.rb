class RMOps::CLI::SV
  desc 'status', 'Service status'
  def status(*args)
    run "sv status #{arg_srvs(args).files.join(' ')}"
  end
end
