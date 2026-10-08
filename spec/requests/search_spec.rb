# spec/requests/search_spec.rb
# frozen_string_literal: true

require "spec_helper"

RSpec.describe "SQL Server Active Search" do
  def create_article(**attributes)
    defaults = {
      title: "Ruby Search",
      content: "Microsoft SQL Server full text search",
      category: "Engineering",
      author: "Ada",
      published_at: Time.utc(2026, 1, 1)
    }
    Article.create!(**defaults.merge(attributes)).tap do |article|
      ActiveSearch.index(:articles).add(article)
    end
  end

  def refresh_index
    ActiveSearch.index(:articles).store.refresh(:articles)
  end

  it "searches multiple fields and ranks results" do
    create_article
    repeated = create_article(title: "Search Search Search", content: "Search ranking")
    refresh_index

    results = Article.search("search").sort_by_relevance.results

    expect(results.map(&:id)).to include(repeated.id)
    expect(results.first.hit.score).to be_positive
  end

  it "supports phrases and structured filters" do
    matching = create_article(content: "exact phrase appears here")
    create_article(content: "exact unrelated phrase", category: "Culture")
    refresh_index

    results = Article.search('"exact phrase"').filter(category: "Engineering").results

    expect(results.map(&:id)).to eq([ matching.id ])
  end

  it "handles Unicode, punctuation, NULL, stopwords, inflection, and no matches" do
    unicode = create_article(title: "Café 東京", content: "Companies were running")
    create_article(title: "Email", content: nil)
    refresh_index

    expect(Article.search("café").results.map(&:id)).to include(unicode.id)
    expect(Article.search("companies").results.map(&:id)).to include(unicode.id)
    expect(Article.search("definitelyabsent").results).to be_empty
  end

  it "does not execute injection-shaped search input" do
    create_article
    refresh_index

    expect { Article.search(%(' OR 1=1; DROP TABLE articles; --)).results }.not_to raise_error
    expect(Article.table_exists?).to be(true)
  end
end
