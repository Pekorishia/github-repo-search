require 'rails_helper'

RSpec.describe GithubRepositoryController, type: :controller do
  context 'GET #index' do
    let(:repo_name) { 'my-repo' }
    let(:raw_repo_name) { 'my-repo' }
    let(:repository_list) do
      [
        ::GithubRepositoryPresenter.new(
          ::GithubRepository.new({ name: repo_name })
        )
      ]
    end

    subject { get :index, params: { repo_name: raw_repo_name } }

    before do
      allow(::GithubRepositoryFacade).to(
        receive(:repository_list_by).with(repo_name).and_return(repository_list)
      )
    end

    shared_examples 'renders template and paginates repositories' do
      it 'properly paginates the array' do
        expect(repository_list).to receive(:paginate)

        subject
      end

      it 'renders the index template' do
        subject

        expect(response).to render_template(:index)
      end
    end

    it 'returns the array paginated array' do
      subject

      expect(assigns(:repos)).to eq repository_list
    end

    it_behaves_like 'renders template and paginates repositories'

    context 'when receiving a invalid string' do
      let(:raw_repo_name) { '&my-=repo' }

      it 'returns the array paginated array' do
        subject

        expect(assigns(:repos)).to eq repository_list
      end

      it_behaves_like 'renders template and paginates repositories'
    end

    context 'when request failed' do
      let(:repository_list) { [] }

      it 'returns a blank array' do
        subject

        expect(assigns(:repos)).to eq []
      end

      it_behaves_like 'renders template and paginates repositories'
    end
  end
end
