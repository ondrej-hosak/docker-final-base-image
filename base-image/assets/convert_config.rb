require 'erb'
require 'yaml'

puts YAML.load(ERB.new(ARGF.gets(nil)).result).to_yaml

