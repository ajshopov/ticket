require "rails_helper"

RSpec.feature "Users can view tickets" do
  before do
    author = FactoryBot.create(:user)

    sublime = FactoryBot.create(:project, name: "Sublime Text 3")
    FactoryBot.create(:tickete, project: sublime,
      author: author,
      name: "Make it shiny!",
      description: "Gradients! Wow")

      ie = FactoryBot.create(:project, name: "Internet Explorer")
      FactoryBot.create(:tickete, project: ie,
        author: author,
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