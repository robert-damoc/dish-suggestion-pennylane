module Api
  module V1
    class RecipesController < ApplicationController
      def index
        recipe = if params[:ingredients]
                   filter_by_ingredients
                 else
                   Recipe.first(6)
                 end

        render json: recipe
      end

      def show
        if recipe
          render json: { recipe: recipe, ingredients: recipe.ingredients }
        else
          render json: recipe.errors
        end
      end

      private

      def recipe
        @recipe ||= Recipe.includes(:ingredients).find(params[:id])
      end

      def filter_by_ingredients
        ingredients = Ingredient.includes(:recipes).where(title: params[:ingredients])
        ingredients_recipes = ingredients.flat_map(&:recipes).uniq

        or_ingredients_identifier = ingredients.pluck(:identifier).map(&:to_i).reduce(&:|)

        ingredients_recipes.select do |recipe|
          identifier = recipe.ingredients_identifier.to_i
          identifier & or_ingredients_identifier == identifier
        end
      end
    end
  end
end
