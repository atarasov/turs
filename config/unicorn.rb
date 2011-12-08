#setup user environment
ENV['RAILS_ENV'] = 'production'
worker_processes(1)
preload_app true
user('root','root')
timeout 40
listen '/var/sockets/turspro.turspro.sock'
#listen 80
working_directory '/opt/www/turspro/current'
pid '/var/run/unicorn/turspro.turspro.pid'
stderr_path "/opt/www/turspro/current/log/unicorn.stderr.log"
stdout_path "/opt/www/turspro/current/log/unicorn.stdout.log"

GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true

before_fork do |server, worker|
   old_pid = "#{server.config[:pid]}.oldbin"
   if File.exists?(old_pid) && server.pid != old_pid
      begin
         Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
   end
end