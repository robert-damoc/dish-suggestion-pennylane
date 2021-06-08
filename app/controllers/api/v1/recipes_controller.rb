module Api
  module V1
    class RecipesController < ApplicationController
      def index
        params[:ingredients] = Ingredient.order('RANDOM()').limit(60).pluck(:title) if params[:test]

        recipe = if params[:ingredients]
                   filter_by_ingredients
                 else
                   Recipe.order('RANDOM()').first(6)
                 end

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
