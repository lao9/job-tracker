require 'rails_helper'

feature "User edits a tag" do
  scenario "user can edit an existing tag" do
    tag1, tag2 = create_list(:tag, 2)

    new_tag_title = "Butthead"

    visit tags_path

    within(".tag_1") do
      click_link('Edit')
    end

    expect(current_path).to eq(edit_tag_path(tag1))

    fill_in 'tag[title]', with: new_tag_title
    click_on 'Update Tag'

    expect(current_path).to eq(tags_path)

    within(".tag_1") do
      expect(page).to have_link(new_tag_title)
    end
    within(".tag_2") do
      expect(page).to have_link(tag2.title)
    end
    expect(page).to_not have_link(tag1.title)

  end
end
