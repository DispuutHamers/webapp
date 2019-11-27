# USAGE:

#require RAILS_ROOT + "/lib/" + "mysqldump.rb"
#dump = Mysqldump.full_backup
#response.headers['Content-Type'] = 'text/plain'
#response.headers['Content-Disposition'] = 'attachment; filename=DATABASE_' + Date.today.to_s + '.bak'
#render :text => dump


class Mysqldump
# ref: http://pauldowman.com/2009/02/08/mysql-s3-backup/
   require "rubygems"
   require "fileutils"

   def Mysqldump.full_backup
        if Rails.env.production?
           env = "production"
        else
           env = "development"
        end

        info = YAML::load(IO.read("config/database.yml"))
        mysql_database = info[env]["database"]
        mysql_user = info[env]["username"]
        mysql_password = info[env]["password"]


        @temp_dir = "/tmp/mysql-backup"
        FileUtils.mkdir_p @temp_dir
        dump_file = "#{@temp_dir}/dump.sql.gz"

        cmd = "mysqldump #{mysql_database} -u #{mysql_user} -p'#{mysql_password}' "
        cmd += "  > #{dump_file}"
        #"  #{mysql_database}  | gzip > #{dump_file}"
        run(cmd)

        ret = File.new(dump_file).read
        FileUtils.rm_rf(@temp_dir)
        ret
   end #full_backup


   def Mysqldump.run(command)
     result = system(command)
     raise("error, process exited with status #{$?.exitstatus}") unless result
   end

end
