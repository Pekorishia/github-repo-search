module Pagination
  extend ActiveSupport::Concern

  require 'will_paginate/array'

  DEFAULT_PER_PAGE = 4

  def paginate
    ->(it) { it.paginate(page: page, per_page: per_page) }
  end

  private

  def page
    params[:page]&.to_i || 1
  end

  def per_page
    params[:per_page]&.to_i || DEFAULT_PER_PAGE
  end
end
