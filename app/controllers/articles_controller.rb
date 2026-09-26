# app/controllers/articles_controller.rb
# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @query = params[:query].to_s

    @articles = if @query.present?
      search = Article.search(@query)
      search = search.filter(category: params[:category]) if params[:category].present?
      search.results
    else
      Article.order(published_at: :desc)
    end
  end
end
