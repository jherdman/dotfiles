class Sys < Thor
  include Thor::Actions

  ## Tasks

  desc "install", "Installs dotfiles on your system"
  def install
    setup_symlinks
    setup_directories
    setup_git
  end

  desc "setup_symlinks", "Sets up required symlinks on your system"
  def setup_symlinks
    self.destination_root = ENV["HOME"]

    Dir['*'].each do |entry|
      next if entry == File.basename(__FILE__) || entry == 'zsh-custom'
      create_link ".#{entry}", entry
    end

    Dir['zsh-custom/*'].each do |entry|
      create_link ".oh-my-zsh/custom/#{File.basename(entry)}", entry
    end
  end

  desc "add_bundle GIT_URL", "Adds a new Vim bundle for use with Pathogen"
  def add_bundle(git_url)
    md = git_url.match(%r%.+/(.+).git$%)
    run "git submodule add #{git_url} vim/bundle/#{md[1]}"
    run "git submodule update --init"
  end

  desc "git_config", "Installs config options for Git"
  def git_config
    append_to_file ".git/config" do
      <<-GIT_CONFIG
      [status]
         showUntrackedFiles = no
      GIT_CONFIG
    end
  end

  desc "setup_directories", "Makes any directories required"
  def setup_directories
    self.destination_root = ENV["HOME"]
    empty_directory ".tmp"
  end

  desc "setup_git", "Runs Git configs"
  def setup_git
    `git config --global user.name`
    `git config --global user.email`
  end
end
