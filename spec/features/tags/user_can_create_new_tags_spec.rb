require 'rails_helper'

describe "User can create new tags" do
  it "user can add a new tag" do
    new_tag_title = "Shante You Stay"

    visit new_tag_path

    fill_in 'tag[title]', with: new_tag_title

    click_on "Create New Tag"

    expect(current_path).to eq(tags_path)
    expect(page).to have_content("All Tags")
    expect(page).to have_content(new_tag_title)
  end
end
