require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: run_final_api.rb environment local_path"

  opts.on("-e ENVIRONMENT","--environment ENVIRONMENT", "running environment") do |v|
    options[:environment] = v
  end
  opts.on("-p PATH", "--path PATH", "local path for project") do |v|
    options[:local_path] = v
  end
end.parse!

options[:environment] ||= 'development'
unless options[:local_path]
  puts "Run -h for info"
  exit 1
end

system 'make api'
system 'docker run --name final-redis -d redis:3.0.3'
system "docker run --link final-redis:redis --name final-api --rm -v #{options[:local_path]}:/home/travis/final-api -p 55555:55555 -e ENV=#{options[:environment]} -ti 'final-ci/final-api:latest'"
system 'docker rm -f final-redis'
