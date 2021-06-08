desc 'Index the ingredients in the Huffman style.'
task compute_ingredients_identifiers: %i[environment] do
  ingredients_ids = []

  Recipe.includes(:ingredients).find_in_batches do |recipes|
    ingredients_ids += recipes.flat_map { |recipe| recipe.ingredients.pluck(:id) }
  end

  ingredients_sorted_by_most_used = ingredients_ids.tally.sort_by { |_, v| -v }

  identifier = 1
  ingredients_sorted_by_most_used.each do |ingredient_id, _frequency|
    Ingredient.find(ingredient_id).update(identifier: identifier)
    identifier <<= 1
  end
end
