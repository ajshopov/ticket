require "rails_helper"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

RSpec.feature "Users can create new tickets" do
  let!(:state) { FactoryBot.create :state, name: "New", default: true }
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    project = FactoryBot.create(:project, name: "Internet Explorer")
    assign_role!(user, :editor, project)

    visit project_path(project)
    click_link "New Tickete"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has been created."
    expect(page).to have_content "State: New"
    within("#tickete") do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "when providing invalid attributes" do
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid decription length" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "No good"
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has not been created."
    expect(page).to have_content "Description is too short"
  end

  # scenario "with multiple attachments", js: true do
  #   fill_in "Name", with: "Add documentation"
  #   fill_in "Description", with: "Testing out attachments for ticketes"

  #   attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
  #   click_link "Add another file"

  #   attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
  #   click_button "Create Tickete"

  #   expect(page).to have_content "Tickete has been created."

  #   within("#tickete .attachments") do
  #     expect(page).to have_content "speed.txt"
  #     expect(page).to have_content "spin.txt"
  #   end
  # end

  scenario "persisting file uploads across form displays" do
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Tickete"
    
    fill_in "Name", with: "Add documentation"
    fill_in "Description", with: "Testing out attachments for ticketes"
    click_button "Create Tickete"

    within("#tickete .attachments") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "with associated tags" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "does not look good"
    fill_in "Tags", with: "browser visual"
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has been created."
    within("#tickete #tags") do
      expect(page).to have_content "browser"
      expect(page).to have_content "visual"
    end
  end
end