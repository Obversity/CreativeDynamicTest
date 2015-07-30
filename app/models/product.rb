class Product < ActiveRecord::Base
  belongs_to :category
  validates :product_id, uniqueness: true
  extend FriendlyId
  friendly_id :product_name, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
