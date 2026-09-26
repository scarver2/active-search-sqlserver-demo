# spec/spec_helper.rb
# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
require "rspec/rails"

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before do
    ArticleDocument.delete_all
    Article.delete_all
  end
end
