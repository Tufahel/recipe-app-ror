class GeneralShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_price = 0
    @foods = current_user.foods.includes(:recipe_foods).map do |food|
      next if food.recipe_foods.empty?

      total_quantity = food.recipe_foods.sum(:quantity)
      price = total_quantity * food.price
      @total_price += price

      {
        name: food.name,
        measurement_unit: food.measurement_unit,
        price: food.price
      }
    end.compact
  end
end
