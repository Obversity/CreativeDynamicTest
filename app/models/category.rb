class Category < ActiveRecord::Base
  has_many :products
  validates :category_name, uniqueness: true
  extend FriendlyId
  friendly_id :category_name, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
