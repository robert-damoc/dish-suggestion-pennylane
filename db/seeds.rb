require 'json'

def json_file_to_hash(filename)
  file = File.read(Rails.root.join('db', filename))

  JSON.parse(file, symbolize_names: true)
end

def recipes
  @recipes ||= begin
    data_hash = json_file_to_hash('recipes.json')

    data_hash[:recipes]
  end
end

def ingredients
  @ingredients ||= begin
    data_hash = json_file_to_hash('ingredients.json')

    data_hash[:ingredients]
  end
end

def sample_ingredients
  @sample_ingredients ||=
    ingredients.map do |title|
      Ingredient.find_or_create_by(title: title) do |ingredient|
        ingredient.unit = Ingredient.units.values.sample
      end
    end
end

SPLIT_DURATIONS_REGEX = /\d+\D*/.freeze
SPLIT_TIME_REGEX = /(\d+)(\D*)/.freeze
def duration_to_minutes(time_duration)
  minutes = 0

  time_duration.gsub!(/\s+/, '')
  time_durations = time_duration.scan(SPLIT_DURATIONS_REGEX)

  time_durations.each do |duration|
    number, quantity = duration.scan(SPLIT_TIME_REGEX).first

    if quantity&.starts_with?('h')
      minutes += (number.to_i * 60)
      next
    end

    minutes += number.to_i
  end

  minutes
end

def create_recipes
  ingredients = sample_ingredients

  recipes.each do |recipe_hash|
    ingredients_count = recipe_hash.delete(:ingredients).count

    tags = recipe_hash.delete(:tags).map do |tag|
      Tag.find_or_create_by(title: tag)
    end

    Recipe.find_or_create_by(name: recipe_hash[:name]) do |recipe|
      recipe.author = recipe_hash[:author]
      recipe.author_tip = recipe_hash[:author_tip]
      recipe.budget = recipe_hash[:budget]
      recipe.difficulty = recipe_hash[:difficulty]
      recipe.image_url = recipe_hash[:image]

      recipe.rate = recipe_hash[:rate].to_f

      recipe.prep_time = duration_to_minutes(recipe_hash[:prep_time])
      recipe.cook_time = duration_to_minutes(recipe_hash[:cook_time])
      recipe.total_time = duration_to_minutes(recipe_hash[:total_time])
      recipe.people_quantity = recipe_hash[:people_quantity].to_i
      recipe.nb_comments = recipe_hash[:nb_comments].to_i

      recipe.tags = tags
      recipe.ingredients = ingredients.shuffle.take(ingredients_count)
    end
  end
end

create_recipes
