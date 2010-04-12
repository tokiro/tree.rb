require 'rubygems'
require 'rake'

task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/tc_*.rb'
  test.verbose = true
end

require 'hanna/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end
  rdoc.rdoc_dir = 'rdoc' # rdoc output folder
  rdoc.title = "tree_visitor #{version}"
  rdoc.main = "README.rdoc" # page to start on
  rdoc.options << '--webcvs=http://github.com/gf/tree_visitor/tree/master/'

  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
  # rdoc.rdoc_files.exclude("")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|

    gem.name = "treevisitor"
    gem.summary = "Implementation of visitor design pattern"
    gem.description = <<-EOF
      Implementation of visitor design pattern. It contains a 'tree.rb'
      command line clone of the tree unix tool.
    EOF

    gem.authors = ["gf"]
    gem.email = "giovanni.ferro@gmail.com"
    gem.homepage = "http://github.com/gf/treevisitor"

    gem.add_dependency('abstract')

    #
    # files
    #
    gem.files = Dir['lib/**/*.rb']
    gem.files << "VERSION.yml"

    gem.test_files = Dir['test/**/*.rb']
    # concat all test files
    gem.files.concat Dir['test_data/**/*']
    gem.files.concat Dir['test_data/**/.dir_with_dot/*']

    #
    # rubyforge
    #
    # gem.rubyforge_project = 'treevisitor'

    Jeweler::GemcutterTasks.new
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/tc_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

#
# rubyforge
#
begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]

    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
          File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/gforge-projects/treevisitor/"
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end
