require 'rails_helper'

RSpec.describe TicketePolicy do
  context "permissions" do
    subject { TicketePolicy.new(user, tickete) }

    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }
    let(:tickete) do
      FactoryBot.create(:tickete, project: project, author: User.new)
    end

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }

      context "when the editor created the ticket" do
        before { tickete.author = user }

        it { should permit_action :update }
      end
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
      it { should permit_action :change_state }
      it { should permit_action :tag }
    end

    context "for managers of other projects" do
      before do
        assign_role!(user, :manager, FactoryBot.create(:project))
      end

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }
    end

    context "for administrators" do
      let(:user) { FactoryBot.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
      it { should permit_action :change_state }
      it { should permit_action :tag }
    end
  end
end
