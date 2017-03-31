require 'rails_helper'

describe "User deletes existing category" do
  scenario "a user can delete a category" do
    category = create(:category)

    visit categories_path

    within(".category_#{category.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("#{category.title} was successfully deleted!")

    visit categories_path

    expect(page).to_not have_content("#{category.title}")

  end
end
