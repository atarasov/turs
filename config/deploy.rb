# _your_login_ - Поменять на ваш логин в панели управления
# _your_project_ - Поменять на имя вашего проекта
# _your_server_ - Поменять на имя вашего сервера (Указано на вкладке "FTP и SSH" вашей панели управления)
# set :repository - Установить расположение вашего репозитория
# У вас должна быть настроена авторизация ssh по сертификатам
require 'bundler/deployment'

set :application, "turspro"
set :repository,  "git@turspro.unfuddle.com:turspro/turspro.git"

dpath = "/opt/www/#{application}"

set :user, "root"
set :use_sudo, false
set :deploy_to, dpath
#set :rake, "/var/lib/gems/1.8/bin/rake"
set :scm, :git
set :branch, "master"
set :keep_releases, 5

role :web, "turs.pro"                          # Your HTTP server, Apache/etc
role :app, "turs.pro"                          # This may be the same as your `Web` server
role :db,  "turs.pro", :primary => true # This is where Rails migrations will run

after "deploy:update_code", :copy_database_config

task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
  run "chmod -R 777 #{release_path}/tmp"
  run "ln -nfs #{shared_path}/system #{release_path}/public/system"
end

set :unicorn_rails, "#{release_path}/vendor/bundle/ruby/1.8/bin/unicorn_rails"
set :unicorn_conf, "#{release_path}/config/unicorn.rb"
set :unicorn_pid, "/var/run/unicorn/#{application}.#{application}.pid"

# - for unicorn - #
#namespace :deploy do
#  desc "Start application"
#  task :start, :roles => :app do
#    run "#{unicorn_rails} -Dc #{unicorn_conf}"
#  end
#
#  desc "Stop application"
#  task :stop, :roles => :app do
#    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
#  end
#
#  desc "Restart Application"
#  task :restart, :roles => :app do
#    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_rails} -Dc #{unicorn_conf}"
#  end
#end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end
end

after 'deploy:update_code', 'bundler:bundle_new_release'