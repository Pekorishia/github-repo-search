require 'rails_helper'

RSpec.describe GithubService, type: :service do
  context '.call_for_repositories_by' do
    let(:repo_name) { 'my-repo' }
    let(:expected_parameters) do
      {
        url: 'https://api.github.com/',
        request: { timeout: 5, open_timeout: 2 }
      }
    end
    let(:expected_path) do
      "/search/repositories?q=#{repo_name}&sort=stars&order=desc"
    end

    subject do
      ::VCR.use_cassette('github_service/call_for_repositories_by') do
        described_class.call_for_repositories_by(repo_name)
      end
    end

    it { expect(subject).to be_an ::Hash }

    it 'caches the request response' do
      expect(::Rails.cache).to(
        receive(:fetch).with([repo_name], expires_in: 1.hour).and_call_original
      )

      subject
    end
  end
end
