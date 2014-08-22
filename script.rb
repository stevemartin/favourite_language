require 'octokit'

# Gets the users favorite programming language
# from their Github account
class GetFavoriteLanguage
  attr_reader :result
  def initialize(github_user)
    api_token = "1b1f1968fab9f829523bdf2227dd85d47fdf7837"
    @client = Octokit::Client.new(:access_token => api_token )
    @github_user     = @client.user(github_user)
    @repos           = get_repos
    @language_data   = get_language_data
    @language_counts = get_language_counts
    p @language_counts
    @result          = get_highest_count.to_s
  end

  def get_repos
    # Perhaps extract to adapter
    @github_user.rels[:repos].get.data
  end

  def get_language_data
    @repos.collect { |repo| repo.rels[:languages].get.data }
  end

  def get_language_counts
    languages = {}
    @language_data.map do |hash|
      languages.merge!(hash) { |key, v1, v2| v1 + v2 }
    end
    languages
  end

  def get_highest_count
    @language_counts.invert[@language_counts.invert.keys.sort.reverse.first]
  end

end

# class ApiClient
#   def initialize(api_token)
#     @client = Octokit::Client.new(:access_token => api_token )
#   end
# end
