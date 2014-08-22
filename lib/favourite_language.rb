# Get a github users favourite programming langauage
# Public class with as simple two call interface
#
# Pass in a valid github username and an api client to new
#
# Call results to get the answer.
class FavouriteLanguage
  attr_reader :github_user
  def initialize(github_user, client)
    @github_user = github_user
    @client      = client
  end

  def results
    favourite_language
  end

  private

  def favourite_language
    @client.favourite_language_for(github_user)
  end
end
