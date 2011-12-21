class MainController < ApplicationController
  
  def index

    @newses = News.limit(4)
    @news = News.first
    @journals = Journal.where(:recomended => true).order("created_at DESC").limit(3)
    if @journals.size < 1
      @journals = Journal.order("created_at DESC").limit(3)
    end

  end

  def about
  end

  def search_rezult
    
  end

  def company_license

  end

  def users_license

  end

end
