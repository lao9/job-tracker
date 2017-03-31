require 'rails_helper'

describe "User edits an existing category" do
  scenario "a user can edit a category" do
    category = create(:category)
    new_category_title = "Butthead"

    visit categories_path

    within(".category_#{category.id}") do
      click_link "Edit"
    end

    expect(current_path).to eq(edit_category_path(category))

    fill_in "category_title", with: new_category_title
    click_on "Update Category"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(new_category_title)
    expect(Category.last.title).to eq(new_category_title)
  end
end
