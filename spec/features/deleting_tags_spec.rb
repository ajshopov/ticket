require 'rails_helper'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

RSpec.feature "Users can delete unwanted tags from a tickete" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:tickete) do
    FactoryBot.create(:tickete, project: project,
      tag_names: "tagtoremove", author: user)
  end

  before do
    login_as(user)
    assign_role!(user, :manager, project)
    visit project_tickete_path(project, tickete)
  end

  # scenario "successfully", js: true do
  #   within tag("tagtoremove") do
  #     click_link "remove"
  #   end
  #   expect(page).to_not have_content "tagtoremove"
  # end
end