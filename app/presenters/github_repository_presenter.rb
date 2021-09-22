class GithubRepositoryPresenter < SimpleDelegator
  def header
    "#{name}, by #{owner}"
  end

  def stars
    "stars: #{stargazers_count}"
  end

  def description
    super&.truncate(MAX_DESCRIPTION_LENGTH, separator: ' ')
  end

  def footer
    "language: #{language || 'none'}, license: #{license || 'none'}"
  end

  MAX_DESCRIPTION_LENGTH = 200

  private_constant :MAX_DESCRIPTION_LENGTH
end
