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

  describe '#description' do
    let(:max_description_length) { 200 }

    let(:expected_string) do
      github_repository.description.truncate(max_description_length,
                                             separator: ' ')
    end

    it { expect(subject.description).to eq expected_string }

    context 'when the description is nil' do
      before { data[:description] = nil }

      it { expect(subject.description).to be_nil }
    end

    context 'when the description does not exceed the max description length' do
      it { expect(subject.description.end_with?('...')).to be_falsey }
    end

    context 'when the description exceeds the max description length' do
      before do
        data[:description] = 'my giant repository description that is soo '\
                             'huge that needs to be splitted into several '\
                             'lines. This also, means that when this '\
                             'description has to be shown in a item, it will '\
                             'probably need to be truncated to fill the'\
                             'space correctly'
      end

      it { expect(subject.description.end_with?('...')).to be_truthy }
    end
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
