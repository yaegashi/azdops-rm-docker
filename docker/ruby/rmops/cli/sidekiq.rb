class RMOps::CLI
  desc 'sidekiq', 'Sidekiq server entrypoint'
  def sidekiq
    mode = RMOps::Utils.env_get('sidekiq')
    logger.info "Sidekiq operation mode: #{mode.inspect}"
    case mode
    when 'enable'
      loop do
        logger.info "Probing rails server at #{REDMINE_CONTAINER_URL}"
        break if RMOps::Utils.probe_server(REDMINE_CONTAINER_URL)
        sleep 10
      end
      RMOps::Tasks.start_sidekiq
    else
      RMOps::Tasks.start_sleep
    end
  end
end
