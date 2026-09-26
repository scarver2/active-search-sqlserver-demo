# app/models/article.rb
# frozen_string_literal: true

class Article < ApplicationRecord
  has_search default: true
end
