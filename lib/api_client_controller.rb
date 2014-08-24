require_relative 'api_repo'
require 'parallel'

# This is where calls to the github api happen
# This object is fairly dumb, and should only care about retreiving
# data from the github api, not performing computations it.
class ApiClientController
  attr_reader :client
  def initialize(client_factory = Octokit::Client,
                 repo_factory = ApiRepo)

    @client       = connect(client_factory)
    @repo_factory = repo_factory

    check_connection(@client)
  end

  def get_users_repos(api_user_data)
    repos = users_repos(api_user_data)
    results = repos.map { |repo| @repo_factory.new(repo) }
    results
  end

  def get_repo_languages(repos, processor = Parallel)
    processor.map(repos) { |repo| repo.languages }
  end

  def get_github_user(github_user)
    client.user(github_user)
  end

  private

  def connect(client_factory)
    client = client_factory.new(netrc: true)
    client
  end

  def check_connection(client)
    client.user
  rescue
    raise 'Check your credientials, could not connect'
  end

  def users_repos(api_user_data)
    api_user_data.rels[:repos].get.data
  end
end
