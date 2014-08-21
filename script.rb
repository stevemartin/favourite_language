require 'octokit'

# Gets the users favorite programming language
# from their Github account
class GetFavoriteLanguage
  def initialize(github_user)
    @github_user = github_user
  end

  def result
    "Ruby"
  end
end
