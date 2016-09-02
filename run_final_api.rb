require 'optparse'

def options
  @options ||= {}
end

def parse_options
  ARGV.push('-h') if ARGV.empty?

  OptionParser.new do |opts|
    opts.banner = 'Usage: run_final_api.rb [--environment ENVIRONMENT] [--sudo] <local path to final-api>'

    opts.on('-e ENVIRONMENT","--environment ENVIRONMENT", "running environment') do |v|
      options[:environment] = v
    end
    opts.on('-b', '--build', 'ensures the script will perform build') do |v|
      options[:build] = v
    end
    opts.on('--sudo', 'forces sudo for docker commands') do |v|
      options[:sudo] = v
    end
  end.parse!

  options[:local_path] = ARGV[0]
  options[:environment] ||= 'development'
end

def validate_config_presence
  raise 'Local path to final-api not specified' if options[:local_path].nil?

  travis_config_path = File.join(options[:local_path], 'config/travis.yml')

  raise "Couldn't locate #{travis_config_path}" unless File.exist?(travis_config_path)
end

def sudo
  'sudo' if @options[:sudo]
end

def build_final_api
  system *[sudo, 'make'].compact
  system *[sudo, 'docker', 'rm', '-f', 'final-redis'].compact
  system *[sudo, 'docker', 'run', '--name', 'final-redis', '-d', 'redis:3.0.3'].compact
  system *[sudo, 'docker', 'rm', '-f','final-api'].compact

  system *[
    sudo, 'docker', 'run',
    '--link', 'final-redis:redis',
    '--name', 'final-api',
    '-v', "#{options[:local_path]}:/home/travis/final-api",
    '-p', '55555:55555',
    '-e', "ENV=#{options[:environment]}",
    'final-ci/final-api:latest'
  ].compact
end

def final_api_exist?
  system *[sudo, 'docker', 'inspect', 'final-api'].compact
end

parse_options

validate_config_presence

if options[:build]
  build_final_api
else
  unless final_api_exist?
    build_final_api
    exit 0
  end
  system *[sudo, 'docker', 'start', '-i', 'final-api'].compact
end
