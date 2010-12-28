class Sys < Thor
  include Thor::Actions

  desc "add_bundle GIT_URL", "Adds a new Vim bundle for use with Pathogen"
  def add_bundle(git_url)
    md = git_url.match(%r%.+/(.+).git$%)
    run "git submodule add #{git_url} vim/bundle/#{md[1]}"
    run "git submodule update --init"
  end
end
