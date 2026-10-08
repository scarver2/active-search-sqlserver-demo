# db/seeds.rb
# frozen_string_literal: true

articles = [
  { title: "Ruby on Rails Search", content: "Native full text search with Microsoft SQL Server.", category: "Engineering", author: "Ada", published_at: Time.utc(2026, 1, 1) },
  { title: "SQL Server Ranking", content: "Search search search: repeated terms demonstrate relevance ranking.", category: "Engineering", author: "Grace", published_at: Time.utc(2026, 2, 1) },
  { title: "A Texas Café", content: "Unicode works: café, jalapeño, and 東京.", category: "Culture", author: "José", published_at: Time.utc(2026, 3, 1) },
  { title: "Punctuation & Phrases", content: "Email demo@example.com; phrase search finds exact words.", category: "Reference", author: "Lin", published_at: Time.utc(2026, 4, 1) },
  { title: "Metadata Only", content: nil, category: "Reference", author: nil, published_at: nil }
]

Article.delete_all
articles.each { |attributes| Article.create!(attributes) }
Article.find_each { |article| ActiveSearch.index(:articles).add(article) }
ActiveSearch.index(:articles).store.refresh(:articles)
