require 'rails_helper'

RSpec.feature "Users can receive notifications about tickete updates" do
  let(:allan) { FactoryBot.create(:user, email: "allan@example.com") }
  let(:bob) { FactoryBot.create(:user, email: "bob@example.com") }
  let(:project) { FactoryBot.create(:project) }
  let(:tickete) do
    FactoryBot.create(:tickete, project: project, author: allan)
  end

  before do
    assign_role!(allan, :manager, project)
    assign_role!(bob, :manager, project)

    login_as(bob)
    visit project_tickete_path(project, tickete)
  end

  scenario "tickete authors automatically receive notifications" do
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"

    email = find_email!(allan.email)
    expected_subject = "[ticket] #{project.name} - #{tickete.name}"
    expect(email.subject).to eq expected_subject

    click_first_link_in_email(email)
    expect(current_path).to eq project_tickete_path(project, tickete)
  end

  scenario "comment authors are automatically subscribed to a tickete" do
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"
    click_link "Sign out"
    
    reset_mailer
    
    login_as(allan)
    visit project_tickete_path(project, tickete)
    fill_in "Text", with: "No it isn't"
    click_button "Create Comment"

    expect(page).to have_content "Comment has been created."
    expect(unread_emails_for(bob.email).count).to eq 1
    expect(unread_emails_for(allan.email).count).to eq 0
  end
end