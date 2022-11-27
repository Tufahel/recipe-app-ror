class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.includes(:foods, :recipe_foods).find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
    @foods = current_user.foods.all
  end

  def create
    @recipe = Recipe.includes(:foods, :recipe_foods).find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    if @recipe_food.save
      flash[:success] = 'Ingredient added successfully'
      redirect_to recipe_path(@recipe.id)
    else
      flash.now[:error] = 'Error: Ingredient could not be added'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_food = RecipeFood.includes(:food, :recipe).find(params[:id])
    if @recipe_food.destroy
      flash[:success] = 'Ingredient was successfully deleted.'
      redirect_to recipes_path
    else
      flash[:error] = 'Something went wrong'
      render :show
    end
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
