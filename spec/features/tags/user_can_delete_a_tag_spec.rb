require 'rails_helper'

feature "User deletes a tag" do
  scenario "user can delete an existing tag" do
    tag1, tag2 = create_list(:tag, 2)

    visit tags_path

    within(".tag_1") do
      click_link('Delete')
    end

    expect(current_path).to eq(tags_path)

    expect(page).to have_link(tag2.title)
    expect(page).to_not have_link(tag1.title)
  end
end
