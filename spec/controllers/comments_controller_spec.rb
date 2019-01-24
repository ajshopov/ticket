require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { Project.create!(name: "Ticketee") }
  let(:state) { State.create!(name: "Hacked") }

  let(:tickete) do
    project.ticketes.create(name: "State transitions",
      description: "Can't be hacked.", author: user)
  end

  context "a user without permission to set state" do
    before :each do
      assign_role!(user, :editor, project)
      sign_in user
    end

    it "cannot transition a state by passing through state_id" do
      post :create, params: { comment: { text: "Did I hack it??",
                                 state_id: state.id },
                      tickete_id: tickete.id }
      tickete.reload
      expect(tickete.state).to be_nil
    end
  end
end