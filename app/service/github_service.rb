class GithubService
  class << self
    def call_for_repositories_by(repo_name)
      ::Rails.cache.fetch([repo_name], expires_in: 1.hour) do
        response = conn.get("/search/repositories?q=#{repo_name}#{sort_by_stars}")
        parse_data(response)
      end
    end

    private

    def conn
      @conn ||= ::Faraday.new(url: 'https://api.github.com/',
                              request: { timeout: 5, open_timeout: 2 })
    end

    def sort_by_stars
      '&sort=stars&order=desc'
    end

    def parse_data(response)
      JSON.parse(response&.body || '{}', symbolize_names: true)
    end
  end
end
