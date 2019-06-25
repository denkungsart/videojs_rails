require 'bundler/gem_tasks'

# Build the version of video.js and tag us to match

VIDEO_JS_RAILS_HOME = File.expand_path(File.dirname(__FILE__))
VIDEO_JS_HOME = File.expand_path('tmp', VIDEO_JS_RAILS_HOME)

VIDEO_JS_RAKE_USAGE = "Usage: rake videojs:update VERSION=5.11.6"

namespace :videojs do
  task :update => [:build, :commit]

  task :build do
    version = ENV['VERSION'] or abort VIDEO_JS_RAKE_USAGE
    FileUtils.mkdir_p(VIDEO_JS_HOME)
    Dir.chdir(VIDEO_JS_HOME) do
      dist_dir = "#{VIDEO_JS_HOME}/video-js-#{version}"
      unless Dir.exist?(dist_dir)
        puts "* Downloading video.js #{version}"
        sh "curl -s -L -O https://github.com/videojs/video.js/releases/download/v#{version}/video-js-#{version}.zip"
        sh "unzip video-js-#{version}.zip -d video-js-#{version}"
      end

      # Copy files into our Rails structure
      puts
      puts "* Copying files to vendor/assets"
      sh "cp #{dist_dir}/font/* #{VIDEO_JS_RAILS_HOME}/vendor/assets/fonts/"
      sh "cp #{dist_dir}/video-js.css #{VIDEO_JS_RAILS_HOME}/vendor/assets/stylesheets/"
      sh "cp #{dist_dir}/video.js #{VIDEO_JS_RAILS_HOME}/vendor/assets/javascripts/"

      # Now, perform some asset_path and other substitutions
      puts
      puts "* Updating videojs-css.erb for Rails asset pipeline"
      css = "#{VIDEO_JS_RAILS_HOME}/vendor/assets/stylesheets/video-js.css"
      File.open("#{css}.erb", 'w') do |out|
        File.foreach(css) do |line|
          # Handle fonts => url('<%= asset_path('vjs.woff') %>') format('woff')
          out <<
            line.gsub(/url\((['"]*)font\/(VideoJS[^\)]+)\)(\s+format[^\)]+\))?/, 'url(<%= asset_path(\1\2) %>)\3')
        end
      end
      sh "rm -f #{css}"
    end
  end

  task :commit do
    version = ENV['VERSION'] or abort VIDEO_JS_RAKE_USAGE

    # Update the gem version
    version_file = "#{VIDEO_JS_RAILS_HOME}/lib/videojs_rails/version.rb"
    lines = File.read(version_file)
    File.open(version_file, 'w') do |out|
      puts "* Setting gem version = #{version}"
      out << lines.sub(/(VERSION\s*=\s*)\S+/, "\\1'#{version}'")
    end

    sh "git add ."
    sh "git commit -m 'Update to video.js v#{version}'"
    sh "git tag -a v#{version} -m \"v#{version}\""
    puts "* Done.  Now run 'rake release' to push to rubygems."
  end
end
