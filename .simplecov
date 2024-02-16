require 'yaml'

path = Pathname.new('.simplecovignore.yml')
config = YAML.load_file(path) || { 'ignore_files' => [] }
if ENV['COVERAGE']
  SimpleCov.start 'rails' do
    config['ignore_files'].each { |file| add_filter file }
  end
end
