class StaticPagesController < ApplicationController
  def index
    @items = Item.all
  end

  def create
  end
  
  def contact
  end
end
