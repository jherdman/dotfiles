class Sys < Thor
  include Thor::Actions

  ## Tasks

  desc "install", "Installs dotfiles on your system"
  def install
    setup_zsh
    setup_symlinks
    setup_git
  end

  desc "setup_zsh", "Clone ZSH"
  def setup_zsh
    run "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh"
  end

  desc "setup_symlinks", "Sets up required symlinks on your system"
  def setup_symlinks
    self.destination_root = ENV["HOME"]

    Dir['*'].each do |entry|
      next if entry == File.basename(__FILE__) || entry == 'zsh-custom'
      create_link ".#{entry}", entry
    end
  end

  desc "setup_git", "Runs Git configs"
  def setup_git
    `git config --global user.name`
    `git config --global user.email`
  end
end
