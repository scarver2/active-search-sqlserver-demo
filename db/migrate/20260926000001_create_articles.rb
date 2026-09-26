# db/migrate/20260926000001_create_articles.rb
# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |table|
      table.string :title, null: false
      table.text :content
      table.string :category
      table.string :author
      table.datetime :published_at
      table.timestamps
    end
  end
end
