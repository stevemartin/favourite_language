require          'octokit'
require_relative 'lib/favourite_language'
require_relative 'lib/api_client'

# Gets the users favorite programming language
# from their Github account
client          = ApiClient.new
favorite_finder = FavouriteLanguage.new(ARGV[0], client)
p favorite_finder.results
