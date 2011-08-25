require 'sprockets'
require 'tempfile'
require 'coffee_script'
require 'sass'
require 'uglifier'

module Filters

  class SprocketFilter < Nanoc3::Filter

    identifier :sprockets
    type :text
    
    Assets = Sprockets::Environment.new(ROOT) do |env|
      assets =  ['javascripts', 'stylesheets', 'images', 'fonts']
      paths =   ['content/assets/', 'lib/', 'vendor/assets/' ].map{|p| assets.map{|f| "#{p}#{f}" } }.flatten

      paths.each{ |path| env.append_path path }
    end unless defined? Assets
    
    def run(content, params = {})
      filename = File.basename(@item[:filename])
      if asset = Assets[filename]
        f = Tempfile.new 'sprockets.tmp'
        f.close
        asset.write_to f.path
        output = IO.read(f.path)
        if filename =~ /js$/
          output = Uglifier.compile output
        end
        return output
      else
        puts "error locating #{filename} / #{@item[:filename]}"
      end
    end

  end
end
