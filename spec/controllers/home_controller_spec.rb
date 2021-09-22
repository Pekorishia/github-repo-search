require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'GET #index' do
    subject { get :index }

    it 'renders the index template' do
      subject

      expect(response).to render_template(:index)
    end
  end
end
