# A simple wrapper for a Github api repo datum
# Could be extended to get commits for a given repo, or other info
#
class ApiRepo
  attr_reader :repo

  def initialize(repo)
    @repo = repo
  end

  def languages
    repo.rels[:languages].get.data
  end
end
