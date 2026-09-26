# db/migrate/20260926000002_create_article_documents.rb
# frozen_string_literal: true

class CreateArticleDocuments < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    create_table :article_documents do |table|
      table.string :article_id, null: false
      table.text :title
      table.text :content
      table.string :category
      table.string :author
      table.datetime :published_at
    end
    add_index :article_documents, :article_id, unique: true
    add_index :article_documents, :id, unique: true, name: :index_article_documents_on_id_for_fulltext

    reversible do |direction|
      direction.up do
        execute "IF FULLTEXTSERVICEPROPERTY('IsFullTextInstalled') <> 1 THROW 50000, 'SQL Server Full-Text Search is not installed', 1"
        execute "IF NOT EXISTS (SELECT 1 FROM sys.fulltext_catalogs WHERE name = 'active_search') CREATE FULLTEXT CATALOG [active_search]"
        execute "CREATE FULLTEXT INDEX ON [article_documents] ([title] LANGUAGE 1033, [content] LANGUAGE 1033) KEY INDEX [index_article_documents_on_id_for_fulltext] ON [active_search] WITH CHANGE_TRACKING MANUAL"
      end
    end
  end
end
