set :application, "startupfavs"
server "startupfavs.com", :app, :web, :db, :primary => true

default_run_options[:pty] = true
set :user, 'sayem'
set :use_sudo, true

set :migrate_target, :current
set :rails_env,       "production"
set :deploy_to, "/home/sayem/htdocs/startupfavs"
set :deploy_via, :copy

default_environment["RAILS_ENV"] = 'production'

set :scm, 'git'
set :repository, 'sayem@startupfavs.com:/home/sayem/htdocs/startupfavs/.git'
set :branch, 'master'

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat /tmp/unicorn.my_site.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat /tmp/unicorn.my_site.pid`"
  end  

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end
