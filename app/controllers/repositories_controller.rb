class RepositoriesController < ApplicationController
  def index
    github = GithubService.new
    @repos_array = github.get_repos(session[:token])
  end

  def create
    github = GithubService.new()
    github.create_repo(params, token)
    redirect_to '/'
  end
end
