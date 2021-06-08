class Api::V1::RecipesController < ApplicationController
  def index
    recipe = Recipe.order('RANDOM()').first(6)

    render json: recipe
  end

  def show
    if recipe
      render json: recipe
    else
      render json: recipe.errors
    end
  end

  private

  def recipe
    @recipe ||= Recipe.find(params[:id])
  end
end
