class RMOps::CLI
  desc 'entrypoint', 'Container entrypoint'
  def entrypoint
    raise 'Not an entrypoint process (PID != 1)' if Process.pid != 1

    begin
      RMOps::Tasks.create_symlinks
      mode = RMOps::Utils.env_get('rails')
      logger.info "Rails operation mode: #{mode.inspect}"
      case mode
      when 'enable'
        RMOps::Tasks.initialize_secret_key_base
        RMOps::Tasks.initialize_database_config
        RMOps::Tasks.bundle_install
        RMOps::Tasks.migrate_database
      end
    rescue StandardError => e
      logger.fatal e.to_s
    end

    logger.info "Starting services in #{SERVICE_DIR}"
    exec "/usr/bin/runsvdir -P #{SERVICE_DIR}"
  end
end
