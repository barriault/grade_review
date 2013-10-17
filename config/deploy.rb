require "bundler/capistrano"

server "ols.tamug.edu", :web, :app, :db, primary: true

set :application, "grade_review"
set :user, "bitnami"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:barriauj/#{application}.git"
set :branch, "master"
set :asset_env, "RAILS_GROUPS=assets RAILS_RELATIVE_URL_ROOT='/grade_review'"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :db do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
  desc "drops the database"
  task :drop do
    run "cd #{current_path}; bundle exec rake db:drop RAILS_ENV=#{rails_env}"
  end
  desc "resets the database"
  task :reset do
    run "cd #{current_path}; bundle exec rake db:reset RAILS_ENV=#{rails_env}"
  end
  desc "migrates the database"
  task :migrate do
    run "cd #{current_path}; bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end
end

namespace :deploy do
  task :start do; end
  task :stop do; end
  task :restart, roles: :app, except: {no_release: true} do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/apache.conf /opt/bitnami/apache2/conf/vhosts/#{application}.conf"
    run "mkdir -p #{shared_path}/config"

    run "ln -fs #{deploy_to}/current /home/#{user}/webapps/#{application}"
    sudo "ln -fs /home/#{user}/webapps/#{application}/public /opt/#{user}/apache2/htdocs/#{application}"

    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end