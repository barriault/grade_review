ActiveScaffold.set_defaults do |config| 
  config.ignore_columns.add [:created_at, :updated_at, :lock_version]
  config.security.default_permission = false
  config.security.current_user_method = :current_user
end