# frozen_string_literal: true
require 'spec_helper'

describe Styxie::Helpers do
  let :controller do
    controller = double('controller')
    controller.class_eval do
      include Styxie::Helpers
    end

    controller
  end

  it '#this_page?' do
    allow(controller).to receive(:controller_name).and_return('tests')
    allow(controller).to receive(:action_name).and_return('index')

    cases = [
      [
        be_truthy, [
          'tests#index',
          '#index'
        ]
      ], [
        be_falsy, [
          'fails#index',
          'tests#show',
          '#show'
        ]
      ]
    ]

    cases.each do |group|
      be_ok, examples = group
      examples.each do |example|
        expect(controller.this_page?(example)).to be_ok
      end
    end
  end

  it '#this_namespace?' do
    allow(controller).to receive(:controller_path).and_return('module/tests')

    cases = [
      [
        be_truthy, [
          'module'
        ]
      ], [
        be_falsy, [
          'whatever'
        ]
      ]
    ]

    cases.each do |group|
      be_ok, examples = group
      examples.each do |example|
        expect(controller.this_namespace?(example)).to be_ok
      end
    end
  end
end
