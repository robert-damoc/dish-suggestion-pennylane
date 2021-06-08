desc 'Memoize the ingredients OR identifiers in recipe'
task compute_recipe_ingredients_identifier: %i[environment] do
  Recipe.includes(:ingredients).find_each do |recipe|
    ingredients_identifiers = recipe.ingredients.pluck(:identifier)

    or_ingredients_identifier = ingredients_identifiers.map(&:to_i).reduce(&:|)
    recipe.update(ingredients_identifier: or_ingredients_identifier)
  end
end
