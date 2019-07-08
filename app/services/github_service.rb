class GithubService

  attr_reader :access_token

#calls initialize in the model to create a local repo?
#not sure why there is @access_token
  def initialize(access_hash = nil)
    @access_token = access_hash["access_token"] if access_hash
  end

#creates a new sesssion - responsible for session token
  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret, code: code}, {'Accept' => 'application/json'}
    JSON.parse(response.body)
  end

#responsible for getting sesssion[;username]
  def get_username(token)

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization'=>"token #{token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end

#responsible for getting @repos_array
  def get_repos(token)
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization'=>"token #{token}", 'Accept' => 'application/json'}
    body = JSON.parse(response.body)
  end

#creates a new repo on github
  def create_repo(params, token)
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization'=>"token #{token}", 'Accept' => 'application/json'}
  end


end
