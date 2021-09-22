require 'rails_helper'

RSpec.describe GithubRepositoryFacade, type: :facade do
  context '.repository_list_by' do
    let(:repo_name) { 'my-repo' }
    let(:request_return) do
      {
        items: [
          {
            name: 'my-repo',
            owner: {
              login: 'user'
            },
            html_url: 'https://github.com/user/my-repo',
            description: 'my repo description',
            stargazers_count: 500,
            language: 'Ruby',
            license: {
              name: 'A license'
            }
          },
          {
            name: 'my-repo-2',
            owner: {
              login: 'user2'
            },
            html_url: 'https://github.com/user2/my-repo-2',
            description: 'my repo 2 description',
            stargazers_count: 100,
            language: 'Java',
            license: {
              name: 'Another license'
            }
          }
        ]
      }
    end

    subject { described_class.repository_list_by(repo_name) }

    before do
      allow(::GithubService).to(
        receive(:call_for_repositories_by).with(repo_name)
      ).and_return(request_return)
    end

    it 'retuns a GithubRepositoryPresenters array', :aggregate_failures do
      response = subject

      expect(response).to be_an ::Array
      expect(response.map(&:class).uniq).to eq [::GithubRepositoryPresenter]
    end

    context 'when api call fails' do
      let(:request_return) { {} }

      it { expect(subject).to eq [] }
    end
  end
end
