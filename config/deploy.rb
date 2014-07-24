# config valid only for Capistrano 3.1
# lock '3.1.0'

set :application, 'capistrano_SK2014'
set :repo_url, 'git@github.com:mario-camacho2/capistrano_SK2014.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'develop'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/usr/local/my_apps/capistranoSK2014'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# SK2014 Custom Configurations
set :jenkins_ssh_user,            "deploy"
set :jenkins_server_dns,          "MCAMACHOC-DV02"
set :jenkins_home,                "/home/deploy/.jenkins"

set :asadmin,                     "/home/deploy/glassfish-3.1.2.2/bin/asadmin"
set :domain,                      "domain1"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :mario do

  task :ls do
    on roles(:app) do
      execute "cd #{current_path} && ls -la"
    end
  end

end

namespace :asadmin do

  namespace :ls do
    task :domains do
      on roles(:app) do
        execute "#{fetch(:asadmin)} list-domains"
      end
    end

    task :apps do
      on roles(:app) do
        execute "#{fetch(:asadmin)} list-applications"
      end
    end

    task :start do
      on roles(:app) do
        execute "#{fetch(:asadmin)} start-domain #{fetch(:domain)}"
      end
    end

    task :stop do
      on roles(:app) do
        execute "#{fetch(:asadmin)} stop-domain #{fetch(:domain)}"
      end
    end

    task :restart do
      on roles(:app) do
        execute "#{fetch(:asadmin)} restart-domain #{fetch(:domain)}"
      end
    end

  end
end
