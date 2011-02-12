class Sys < Thor
  include Thor::Actions

  ## Tasks

  desc "install", "Installs dotfiles on your system"
  def install
    setup_symlinks
    setup_constants
  end

  desc "setup_symlinks", "Sets up required symlinks on your system"
  def setup_symlinks
    self.destination_root = ENV["HOME"]

    Dir['*'].each do |entry|
      next if entry == File.basename(__FILE__)
      create_link ".#{entry}", File.join(File.expand_path(File.dirname(__FILE__)), entry)
    end
  end

  desc "setup_constants", "Sets up required constants on your system"
  def setup_constants
    self.destination_root = File.join(ENV["HOME"], ".dotfiles")

    create_file "oh-my-zsh/custom/constants.zsh" do
      git_author_name = ask "What is the name you'd like to use with Git?:"
      git_email       = ask "What is the email you'd like to use with Git?:"

      <<-CONFIG
      export GIT_AUTHOR_NAME="#{git_author_name}"
      export GIT_COMMITTER_NAME="#{git_author_name}"
      export EMAIL="#{git_email}"
      CONFIG
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
end
