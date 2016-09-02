require 'optparse'

def get_options
  ARGV.push('-h') if ARGV.empty?
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: run_final_api.rb [--environment ENVIRONMENT] [--sudo] <local path to final-api>"

    opts.on("-e ENVIRONMENT","--environment ENVIRONMENT", "running environment") do |v|
      options[:environment] = v
    end
    opts.on("-b", "--build", "ensures the script will perform build") do |v|
      options[:build] = v
    end
    opts.on("--sudo", "forces sudo for docker commands") do |v|
      options[:sudo] = v
    end
  end.parse!

  options[:local_path] = ARGV[0]
  options[:environment] ||= 'development'
  options
end

def validate_config_presence(options)
  raise "Local path to final-api not specified" if options[:local_path].nil?

  travis_config_path = File.join(options[:local_path], 'config/travis.yml')

  raise "Couldn't locate #{travis_config_path}" unless File.exists?(travis_config_path)
end

def get_command_prefix(options)
  "sudo" if options[:sudo]
end

options = get_options
begin
  validate_config_presence(options)
rescue Exception => e
  p e
  exit 1
end

sudo = get_command_prefix(options)
system "#{sudo} make"
system "#{sudo} docker run --name final-redis -d redis:3.0.3"
if options[:build]
  system "#{sudo} docker rm final-api"
  system "#{sudo} docker run --link final-redis:redis --name final-api -v #{options[:local_path]}:/home/travis/final-api -p 55555:55555 -e ENV=#{options[:environment]} -ti 'final-ci/final-api:latest'"
else
  system "#{sudo} docker start -i final-api"
  system "#{sudo} docker rm -f final-redis"
end

