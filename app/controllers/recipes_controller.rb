class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = RecipeFood.all
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash[:success] = 'Recipe created succesfully'
      redirect_to recipes_url
    else
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    flash[:success] = 'Recipe deleted successfully'
    redirect_to recipes_url
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update_attribute(:public, true)
    redirect_to recipes_url
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end