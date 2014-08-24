# Get a github users favourite programming langauage
# Public class with as simple two call interface
#
# Initialize with a valid github username and an api client.
#
# Call results to get the answer.
#
# This class cares about computing language data for
# a github user, retreived using an api client adapter
# and working out the users favorite language.
#
class FavouriteLanguage
  attr_reader :github_user
  def initialize(github_user, client)
    @github_user = github_user
    @client      = client
  end

  def get
    response = github_user_data

    return '404 - User not found!' if response == '404'
    with_max_loc(response)
  end

  private

  def with_max_loc(response)
    repos     = users_repos(response)
    counts    = language_counts(repos)
    max       = counts.invert.keys.sort.reverse.first
    results   = counts.reject { |_key, value| value < max }
    languages = results.keys

    return languages.first if languages.size < 2
    languages
  end

  def users_repos(response)
    # Gives us an array of the users repos from the client.
    @client.get_users_repos(response)
  end

  def language_counts(repos)
    languages     = {}
    api_languages = @client.get_repo_languages(repos)

    api_languages.map do |hash|
      languages.merge!(hash) { |_key, v1, v2| v1 + v2 }
    end
    languages
  end

  def github_user_data
    @client.get_github_user(github_user)
  rescue
    return '404'
  end
end
