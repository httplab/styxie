# frozen_string_literal: true
require 'styxie'

class TestsController < ActionController::Base

  append_view_path Styxie::Engine.paths['app/views']

  include Styxie::Initializer
  helper_method :styxie_initialize

  def index
    styxie_initialize_with data: 'test'
  end

end
