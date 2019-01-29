# require 'rails_helper'

# RSpec.feature "Users can search for ticketes matching specific criteria" do
#   let(:user) { FactoryBot.create(:user) }
#   let(:project) { FactoryBot.create(:project) }
#   let!(:tickete_1) do
#     FactoryBot.create(:tickete, name: "Create Projects",
#       project: project, author: user, tag_names: "iteration_1")
#   end
#   let!(:tickete_2) do
#     FactoryBot.create(:tickete, name: "Create Users",
#       project: project, author: user, tag_names: "iteration_2")
#   end

#   before do
#     assign_role!(user, :manager, project)
#     login_as(user)
#     visit project_path(project)
#   end

#   scenario "searching by tag" do
#     fill_in "Search", with: "tag:iteration_1"
#     click_button "Search"
#     within('#ticketes') do
#       expect(page).to have_link "Create Projects"
#       expect(page).to_not have_link "Create Users"
#     end
#   end
# end