require 'rails_helper'

RSpec.describe "Ticketes API" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:state) { FactoryBot.create(:state, name: "Open") }
  let(:tickete) do
    FactoryBot.create(:tickete, project: project, state: state, author: user)
  end

  before do
    assign_role!(user, :manager, project)
    user.generate_api_key
  end

  context "as an authenticated user" do
    let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end

    it "retrieves a tickete's information" do
      get api_project_tickete_path(project, tickete, format: :json),
        :params => {}, headers: headers
      expect(response.status).to eq 200

      json = TicketeSerializer.new(tickete).to_json
      expect(response.body).to eq json
    end
  end
end