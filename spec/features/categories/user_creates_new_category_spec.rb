require 'rails_helper'

describe "User creates a new category" do
  scenario "a user can create a new category" do
    new_category = "Engineering"

    visit new_category_path

    fill_in "category_title", with: new_category

    click_button "Create"

    expect(current_path).to eq(categories_path)
    expect(page).to have_content(new_category)
    expect(Category.count).to eq(1)

  end
  scenario "a user cannot create an already existing category" do
    category1 = create(:category)

    visit new_category_path

    fill_in "category_title", with: category1.title

    click_button "Create"

    expect(page).to have_content("Title has already been taken")
    expect(Category.count).to eq(1)
  end
end
