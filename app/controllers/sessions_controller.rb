class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
  
    github = GithubService.new
    access_hash = github.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])
    session[:token] = access_hash["access_token"]

    session[:username] = github.get_username(session[:token])

    redirect_to '/'
  end
end
