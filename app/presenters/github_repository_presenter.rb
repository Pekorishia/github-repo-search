class GithubRepositoryPresenter < SimpleDelegator
  def header
    "#{name}, by #{owner}"
  end

  def stars
    "stars: #{stargazers_count}"
  end

  def footer
    "language: #{language || 'none'}, license: #{license || 'none'}"
  end
end
