class ApiRepo
  attr_reader :repo

  def initialize(repo, github_user)
    @github_user = github_user
    @repo        = repo
  end

  def languages
    repo.rels[:languages].get.data
  end

end
