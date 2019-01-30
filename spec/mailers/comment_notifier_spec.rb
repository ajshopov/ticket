require "rails_helper"

RSpec.describe CommentNotifier, type: :mailer do
  describe "created" do
    let(:project) { FactoryBot.create(:project) }
    let(:tickete_owner) { FactoryBot.create(:user) }
    let(:tickete) do
      FactoryBot.create(:tickete, project: project, author: tickete_owner)
    end

    let(:commenter) { FactoryBot.create(:user) }
    let(:comment) do
      Comment.new(tickete: tickete, author: commenter, text: "Test comment")
    end

    let(:email) do
      CommentNotifier.created(comment, tickete_owner)
    end

    it "sends out an email notificaiton about a new comment" do
      expect(email.to).to include tickete_owner.email
      title = "#{tickete.name} for #{project.name} has been updated."
      expect(email.body.to_s).to include title
      expect(email.body.to_s).to include "#{commenter.email} wrote:"
      expect(email.body.to_s).to include comment.text
    end
  end
end