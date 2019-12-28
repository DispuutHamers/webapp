# config valid only for Capistrano 3.1
set :application, 'Hamers'
set :repo_url, 'git@bitbucket.org:jackozi/hamers.git'
set :rvm_ruby_version, '2.6.5'
set :default_env, { rvm_bin_path: '/home/deploy/.rvm/bin' }

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :rails_env, "production"
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty
set :stages, %w(production)
# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{tmp/rpush.pid log/rpush.log config/secret_token.rb config/database.yml config/key.pem certificates/zondersikkel.nl-cert.pem certificates/zondersikkel.nl-chain.pem certificates/zondersikkel.nl-fullchain.pem certificates/zondersikkel.nl-key.pem}

# Default value for linked_dirs is []
set :linked_dirs, %w{tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc "Restart passenger process"
  task :restart  do
    on roles(:web) do |host|
      execute "mkdir -p #{current_path}/tmp"
      execute "touch #{current_path}/tmp/restart.txt"
    end
  end

  desc "Write cronfile"
  task :whenever do
    on roles(:web) do |host|
        execute "whenever -w"
      end
  end
end

after "deploy", "deploy:restart"
after "deploy", "deploy:whenever"

