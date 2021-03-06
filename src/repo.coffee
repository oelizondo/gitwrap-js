class Repo
	BASE_URL = "http://api.github.com/repos"
	PUBLIC_REPOS = "https://api.github.com/repositories"
	Repos = []
	CURRENTLASTREPO = 0
	constructor: (attributes={}) ->
		@name = attributes.full_name
		@url = attributes.url
		@forks = attributes.forks_count
		@language = attributes.language
		@stars = attributes.stargazers_count

	@fetchRepo: (username, repoName, callback) ->
		$.ajax({
			type: 'GET'
			url: "#{BASE_URL}/#{username}/#{repoName}"
			success: (data) ->
				nRepo = new Repo(data)
				callback(nRepo) if callback
		})

	@fetchAllRepos: (callback) ->
		$.ajax({
			type: 'GET'
			url: "#{PUBLIC_REPOS}?since=#{CURRENTLASTREPO}"
			success: (data) ->
				for repo in data
					newRepo = new Repo(repo)
					Repos.push(newRepo)
				CURRENTLASTREPO = Repos.length-1
				callback(Repos) if callback
		})