require          'octokit'
require_relative 'lib/favourite_language'
require_relative 'lib/api_client_controller'

# Gets the users favorite programming language
# from their Github account
github_user     = ARGV[0]
client          = ApiClientController.new
favorite_finder = FavouriteLanguage.new(github_user, client)
p favorite_finder.get
