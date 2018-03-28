# frozen_string_literal: true
require 'spec_helper'

describe Styxie::Initializer do
  let :controller do
    controller = double('controller')
    controller.class_eval do
      include Styxie::Initializer
    end

    controller
  end

  it '#styxie_initialize_with' do
    expect(controller.styxie_configuration).to eq({})
    controller.styxie_initialize_with(test: 'data')
    expect(controller.styxie_configuration).to eq({ test: 'data' })
  end

  it '#styxie_initialize' do
    controller.stub(controller_path: 'module/tests')
    controller.stub(action_name: 'index')
    result = controller.styxie_initialize
    expect(result).to include "Styxie.applyInitializer('ModuleTests', 'index', {});"
    expect(result.html_safe?).to be_truthy
  end

  describe '#styxie_formatted_data' do
    let(:data) { { hello_world: 'data' } }

    it 'camel cased' do
      result = controller.styxie_formatted_data(data, true)
      expect(result).to eq({ 'helloWorld' => 'data' })
    end

    it 'snake cased' do
      result = controller.styxie_formatted_data(data, false)
      expect(result).to eq(data)
    end
  end
end
