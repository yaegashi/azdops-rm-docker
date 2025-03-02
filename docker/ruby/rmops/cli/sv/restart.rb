class RMOps::CLI::SV
  desc 'restart', 'Service restart'
  def restart(*args)
    run "sv restart #{arg_srvs(args).files.join(' ')}"
  end
end
