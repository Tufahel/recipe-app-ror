class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public]

  def public
    @recipes = Recipe.where(public: true)
  end

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:success] = 'Recipe added successfully'
      redirect_to recipes_path
    else
      flash.now[:error] = 'Error: Recipe could not be added'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @recipe = Recipe.includes(:foods).find(params[:id])
    @foods = @recipe.foods
    @recipe_foods = @recipe.recipe_foods
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = 'Recipe was successfully deleted.'
      redirect_to recipes_path
    else
      flash[:error] = 'Something went wrong'
      render :show
    end
  end

  def recipe_params
    my_recipe = params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
    my_recipe[:user] = current_user
    my_recipe
  end
end
