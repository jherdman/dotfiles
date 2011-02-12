desc "Install the dot files into user's home directory"
task :install do
  Dir['*'].each do |entry|
    next if entry == "Rakefile"

    begin
      FileUtils.ln_sf(File.join(File.dirname(File.expand_path(__FILE__)), entry), File.join(ENV["HOME"], ".#{entry}"), :verbose => true)
    rescue Errno::EEXIST => e
      puts e.message
    end
  end
end
