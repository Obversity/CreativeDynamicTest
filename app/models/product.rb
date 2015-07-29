class Product < ActiveRecord::Base
  belongs_to :category
  validates :product_id, uniqueness: true
end
