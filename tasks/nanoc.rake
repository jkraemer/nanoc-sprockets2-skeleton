require 'rake/clean'
CLEAN.include("output/**")

desc "Compile site HTML using nanoc."
task :compile => :touch_sprockets do
  system 'nanoc co'
end

desc "Start the nanoc autocompiler."
task :auto do
  system 'nanoc autocompile -H webrick -p 3000'
end

desc "Start the nanoc autocompiler in the background."
task :quiet do
  system 'nanoc autocompile -H webrick -p 3000 > log/nanoc-autocompile.log 2>&1 &'
end

desc "triggers sprocket rebuild if snippets have changed"
task :touch_sprockets do
  [
    ['content/assets/javascripts/application.js', './**/*.{js,coffee}'],
    ['content/assets/stylesheets/application.css', './**/*.{css,scss}']
  ].each do |file, pattern|
    base_mtime = File.mtime file
    Dir[pattern].each do |snippet|
      if File.mtime(snippet) > base_mtime
        new_content = IO.read(file).gsub /^(.*TIMESTAMP:).*$/, "\\1#{Time.now}"
        (File.open(file, 'w') << new_content).close
        break
      end
    end
  end
end