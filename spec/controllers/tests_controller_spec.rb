# frozen_string_literal: true
require 'spec_helper'

describe TestsController, type: :controller do
  render_views

  it 'index' do
    get :index
    expect(response.body).to have_content("Styxie.applyInitializer('Tests', 'index', {\"data\":\"test\"})")
  end
end
