class HomeController < ApplicationController
  def index
    @page = Page.find_by_title("Home")
  end

end
