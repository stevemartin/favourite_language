# Installation
This app uses the `rvm/rbenv` generic `.ruby-version` config to set up ruby.

## Install the gems

    bundle

## Netrc
The app uses netrc to authenticate with github, you'll need to have, or generate, an
access token for your user.

### If you dont have a `~/.netrc`
Copy the `.netrc` template file to your home folder if you don't already have one

    cp .netrc.dist ~/.netrc

Now replace the credentials in the `.netrc` file with your own

### If you do have a `~/.netrc`
Add the credentials in the `.netrc.dist` file into your local `~/.netrc` and replace the boilerplate with your actual credentials.

* NOTE: To run the integration tests you will need to have the correct `netrc` settings.

# Usage
In the app root folder:

    ruby script.rb tevio

    $-> :Ruby

# How it works

### The naive way ( current implementation ).
The way this app calculates a users favourite language is by getting a list of the users repos and then summing the number of lines for each given language from all of them.

IMO, this is not the best way it could be done, because a user can fork a repo and contribute a small amount of code
to one part of it, say the bash build script, when the primary code base might be written in a different language, say, C, or Javascript. The loc for the primary language ( C or Javascript ) would have more impact on the result than the bash lines would.

### A more accurate way.
I investigated using a more sophisticated approach, by looking at a users commits for a given repo and analyzing the filenames and blobs to see which types of language each commit contains and the lines of code of each, then summing the numbers in the commits ( rather than at the repo level ) the result would have given a much better overview as it would indicate which langauges the user has *actually committed with*. This proved to be a bit too complicated because ...

Github uses a library called github-linguist which I thought that I would be able to use to solve this problem, but it turns out it is very coupled the the local filesystem that it is running on and wouldn't work well with remote api calls ( would have to cache each blob locally and turn it into a file ). While I think this approach would be better in the long run, the amount of work required was considerable.
