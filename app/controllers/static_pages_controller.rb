class StaticPagesController < ApplicationController
  def index
    @items = Item.all.last(9)
  end

  def create
  end
  
  def contact
  end
end
