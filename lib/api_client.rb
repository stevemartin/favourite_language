require_relative 'api_repo'

class ApiClient
  def initialize(client_factory = Octokit::Client)
    @client = client_factory.new(netrc: true)
  end

  def favourite_language_for(github_user, repo_factory = ApiRepo)
    @repo_factory = repo_factory
    response = get_github_user(github_user)
    return "404 - User not found!" if response == '404'
    get_highest_count(response)
  end

  private
  def get_highest_count(user)
    repos = get_users_repos(user)
    counts = get_language_counts(repos)
    counts.invert[counts.invert.keys.sort.reverse.first]
  end

  def get_language_counts(repos)
    languages = {}
    get_repo_languages(repos).map do |hash|
      languages.merge!(hash) { |key, v1, v2| v1 + v2 }
    end
    languages
  end

  def get_users_repos(github_user)
    users_repos(github_user).map { |repo| @repo_factory.new(repo, github_user) }
  end

  def users_repos(github_user)
    github_user.rels[:repos].get.data
  end

  def get_repo_languages(repos)
    repos.collect { |repo| repo.languages }
  end

  def get_github_user(github_user)
    begin
      response = @client.user(github_user)
    rescue
      return '404'
    end
    response
  end
end
