class GithubRepository
  attr_reader :name,
              :owner,
              :license,
              :html_url,
              :language,
              :description,
              :stargazers_count

  def initialize(data)
    @name = data[:name]
    @html_url = data[:html_url]
    @language = data[:language]
    @description = data[:description]
    @stargazers_count = data[:stargazers_count]

    @owner = get_owner(data)
    @license = get_license(data)
  end

  private

  def get_owner(data)
    data[:owner].present? ? data[:owner][:login] : nil
  end

  def get_license(data)
    data[:license].present? ? data[:license][:name] : nil
  end
end
