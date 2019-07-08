class RepositoriesController < ApplicationController
  def index
    # response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # @repos_array = JSON.parse(response.body)
    github = GithubService.new
    @repos_array = github.get_repos(session[:token])
  end

  def create
    github = GithubService.new(params[:name], session[:token])

    # response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
