class RMOps::CLI
  desc 'rails', 'Rails server entrypoint'
  def rails
    mode = RMOps::Utils.env_get('rails')
    logger.info "Rails operation mode: #{mode.inspect}"
    case mode
    when 'enable'
      RMOps::Tasks.start_rails_server
    when 'debug'
      RMOps::Tasks.start_debug_server
    else
      RMOps::Tasks.start_staticsite_server
    end
  end
end
