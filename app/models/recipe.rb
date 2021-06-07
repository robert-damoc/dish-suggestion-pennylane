class Recipe < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :name, presence: true, uniqueness: true
end
