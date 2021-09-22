require 'rails_helper'

RSpec.describe GithubRepositoryPresenter, type: :presenter do
  let(:github_repository) { ::GithubRepository.new(data) }
  let(:data) do
    {
      'name': 'my-repo',
      'owner': {
        'login': 'user'
      },
      'html_url': 'https://github.com/user/my-repo',
      'description': 'my repo description',
      'stargazers_count': 500,
      'language': 'Ruby',
      'license': {
        'name': 'A license'
      }
    }
  end

  subject { described_class.new(github_repository) }

  describe '#header' do
    let(:expected_string) do
      "#{github_repository.name}, by #{github_repository.owner}"
    end

    it { expect(subject.header).to eq expected_string }
  end

  describe '#stars' do
    let(:expected_string) { "stars: #{github_repository.stargazers_count}" }

    it { expect(subject.stars).to eq expected_string }
  end

  describe '#footer' do
    let(:expected_string) do
      "language: #{github_repository.language}, "\
        "license: #{github_repository.license}"
    end

    it { expect(subject.footer).to eq expected_string }

    context 'when language is not defined' do
      before { allow(github_repository).to receive(:language).and_return nil }

      let(:expected_string) do
        "language: none, license: #{github_repository.license}"
      end

      it { expect(subject.footer).to eq expected_string }
    end

    context 'when license is not defined' do
      before { allow(github_repository).to receive(:license).and_return nil }

      let(:expected_string) do
        "language: #{github_repository.language}, license: none"
      end

      it { expect(subject.footer).to eq expected_string }
    end
  end
end
