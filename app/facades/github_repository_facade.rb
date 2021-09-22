class GithubRepositoryFacade
  class << self
    def repository_list_by(repo_name)
      items = ::GithubService.call_for_repositories_by(repo_name)[:items]

      items&.map do |item|
        ::GithubRepositoryPresenter.new(::GithubRepository.new(item))
      end || []
    end
  end
end
