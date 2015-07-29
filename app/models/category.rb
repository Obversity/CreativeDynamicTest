class Category < ActiveRecord::Base
  has_many :products
  validates :category_name, uniqueness: true
end
