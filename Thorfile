class Sys < Thor
  include Thor::Actions

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
