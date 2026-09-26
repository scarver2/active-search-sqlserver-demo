# config/search.rb
# frozen_string_literal: true

ActiveSearch.define_index(:articles) do
  text :title
  text :content
  string :category
  string :author
  datetime :published_at
end
