require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should save category with valid attributes" do
    category = Category.new(name: 'Cinematography', required: false)
    assert category.save
  end

  test "should not save category without a name" do
    category = Category.new(required: true)
    assert_not category.save, "Saved the category without a name"
    assert_includes category.errors[:name], "can't be blank"
  end

  test "default required should be false" do
    category = Category.create!(name: 'Editing')
    assert_not category.required, "Category 'required' defaulted to true"
  end
end
