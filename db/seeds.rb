require 'json'

file = File.read(Rails.root.join('db', 'recipes.json'))
data_hash = JSON.parse(file, symbolize_names: true)

recipes = data_hash[:recipes]

# recipes = [{
#   "rate": "5",
#   "author_tip": "",
#   "budget": "bon marché",
#   "prep_time": "1h15",
#   "ingredients": [
#     "600g de pâte à crêpe",
#     "1/2 orange",
#     "1/2 banane",
#     "1/2 poire pochée",
#     "1poignée de framboises",
#     "75g de Nutella®",
#     "1poignée de noisettes torréfiées",
#     "1/2poignée d'amandes concassées",
#     "1cuillère à café d'orange confites en dés",
#     "2cuillères à café de noix de coco rapée",
#     "1/2poignée de pistache concassées",
#     "2cuillères à soupe d'amandes effilées"
#   ],
#   "name": "6 ingrédients que l’on peut ajouter sur une crêpe au Nutella®",
#   "author": "Nutella",
#   "difficulty": "très facile",
#   "people_quantity": "6",
#   "cook_time": "1h10 min",
#   "tags": [
#     "Crêpe",
#     "Crêpes sucrées",
#     "Végétarien",
#     "Dessert"
#   ],
#   "total_time": "25 min",
#   "image": "https://assets.afcdn.com/recipe/20171006/72810_w420h344c1cx2544cy1696cxt0cyt0cxb5088cyb3392.jpg",
#   "nb_comments": "1"
# }.with_indifferent_access]

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

recipes.each do |recipe_hash|
  # TODO: add ingredients after defining the structure
  _ingredients = recipe_hash.delete(:ingredients)

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
  end
end
