require 'rails_helper'

class PaginationTestController < ApplicationController
  include Pagination

  def index
    @result = params[:array].then(&paginate)

    render status: :ok, json: nil
  end
end

RSpec.describe PaginationTestController, type: :controller do
  before do
    ::Rails.application.routes.draw do
      get '/index' => 'pagination_test#index'
    end
  end

  after { ::Rails.application.reload_routes! }

  describe '#paginate' do
    let(:per_page) { 4 }
    let(:array) { %w[string1 string2 string3 string4 string5] }

    subject do
      get :index, params: { array: array, page: page, per_page: per_page }
    end

    context 'when the page contains the total amount per page' do
      let(:page) { 1 }
      let(:expect_result) { %w[string1 string2 string3 string4] }

      it 'correctly returns the paginated array' do
        subject

        expect(assigns(:result)).to match_array(expect_result)
      end
    end

    context 'when the page contains less than the total amount per page' do
      let(:page) { 2 }
      let(:expect_result) { ['string5'] }

      it 'correctly returns the paginated array' do
        subject

        expect(assigns(:result)).to match_array(expect_result)
      end
    end

    context 'when the page does not contain any element' do
      context 'when the page number is less than maximum one' do
        let(:page) { 0 }
        let(:expect_result) { [] }

        it 'raises range error for invalid page number' do
          expect { subject }.to(
            raise_error(::RangeError).with_message('invalid page: 0')
          )
        end
      end

      context 'when the page number is greater than maximum one' do
        let(:page) { 3 }
        let(:expect_result) { [] }

        it 'returns a empty array' do
          subject

          expect(assigns(:result)).to match_array(expect_result)
        end
      end
    end
  end
end
