# frozen_string_literal: true
require 'spec_helper'

describe TestsController, type: :controller do
  render_views

  it 'index' do
    get :index
    response.body.should have_content('Styxie.Initializers.Tests.initialize({"data":"test"})')
    response.body.should have_content('Styxie.Initializers.Tests[\'index\']({"data":"test"})')
  end
end
