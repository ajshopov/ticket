require "rails_helper"

RSpec.feature "Users can view tickets" do
  before do
    sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    FactoryGirl.create(:tickete, project: sublime,
      name: "Make it shiny!",
      description: "Gradients! Wow")

      ie = FactoryGirl.create(:project, name: "Internet Explorer")
      FactoryGirl.create(:tickete, project: ie,
        name: "Standards Compliance",
        description: "Problematic")

      visit "/"
  end

  scenario "for a given project" do
    click_link "Sublime Text 3"

    expect(page).to have_content "Make it shiny!"
    expect(page).to_not have_content "Standards Compliance"

    click_link "Make it shiny!"
    within("#tickete h2") do
      expect(page).to have_content "Make it shiny!"
    end
     
    expect(page).to have_content "Gradients! Wow"
  end
end