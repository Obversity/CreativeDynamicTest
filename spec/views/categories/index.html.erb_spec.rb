require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    assign(:categories, [
      Category.create!(
        :category_name => "Category Name"
      ),
      Category.create!(
        :category_name => "Category Name"
      )
    ])
  end

end
