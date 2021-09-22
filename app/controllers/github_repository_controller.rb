class GithubRepositoryController < ApplicationController
  include Pagination

  def index
    repo_name = sanitize(params[:repo_name])
    @repos = ::GithubRepositoryFacade.repository_list_by(repo_name)
                                     .then(&paginate)
  end

  private

  def sanitize(string)
    string.gsub(/[!@%&="]/, '')
  end
end
