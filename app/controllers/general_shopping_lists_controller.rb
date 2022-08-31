class GeneralShoppingListsController < ApplicationController
  def index
    @missing_food = RecipeFood.all
    @amount = RecipeFood.all.count
  end
end
