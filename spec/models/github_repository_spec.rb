require 'rails_helper'

RSpec.describe GithubRepository, type: :model do
  context 'initialization' do
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

    subject { described_class.new(data) }

    shared_examples 'basic attributes' do
      it 'successfully assigns the basic attributes', :aggregate_failures do
        object = subject

        expect(object.name).to eq data[:name]
        expect(object.html_url).to eq data[:html_url]
        expect(object.language).to eq data[:language]
        expect(object.description).to eq data[:description]
        expect(object.stargazers_count).to eq data[:stargazers_count]
      end
    end

    it_behaves_like 'basic attributes'

    it 'successfully assigns the modular attributes', :aggregate_failures do
      object = subject

      expect(object.owner).to eq data[:owner][:login]
      expect(object.license).to eq data[:license][:name]
    end

    context 'when no owner was received' do
      before { data[:owner] = nil }

      it_behaves_like 'basic attributes'

      it 'fails to assign one of the modular attributes', :aggregate_failures do
        object = subject

        expect(object.owner).to be_nil
        expect(object.license).to eq data[:license][:name]
      end
    end

    context 'when no license was received' do
      before { data[:license] = nil }

      it_behaves_like 'basic attributes'

      it 'fails to assign one of the modular attributes', :aggregate_failures do
        object = subject

        expect(object.owner).to eq data[:owner][:login]
        expect(object.license).to be_nil
      end
    end
  end
end
