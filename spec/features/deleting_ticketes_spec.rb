require "rails_helper"

RSpec.feature "Users can delete ticketes" do
  let(:project) { FactoryGirl.create(:project) }
  let(:tickete) { FactoryGirl.create(:tickete, project: project) }

  before do
    visit project_tickete_path(project, tickete)
  end

  scenario "successfully" do
    click_link "Delete Tickete"

    expect(page).to have_content "Tickete has been deleted."
    expect(page.current_url).to eq project_url(project)
  end
end