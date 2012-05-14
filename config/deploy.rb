set :application, "startupfavs"
server "startupfavs.com", :app, :web, :db, :primary => true

default_run_options[:pty] = true
set :user, 'sayem'
set :use_sudo, true

set :migrate_target, :current
set :rails_env, "production"
set :deploy_to, "/home/sayem/htdocs/startupfavs"

default_environment["RAILS_ENV"] = 'production'

set :scm, 'git'
set :repository, 'sayem@startupfavs.com:/home/sayem/htdocs/startupfavs/.git'
set :branch, 'master'

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat /home/sayem/htdocs/startupfavs/tmp/pids/unicorn.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat /home/sayem/htdocs/startupfavs/tmp/pids/unicorn.pid`"
  end  
end
