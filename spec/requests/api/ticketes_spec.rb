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

    it "can create a tickete" do
      params = {
        format: "json",
        tickete: {
          name: "Test Tickete",
          description: "Testing it out.",
          author_id: user
        }
      }

      post api_project_ticketes_path(project, params), :params => {}, headers: headers
      expect(response.status).to eq 201

      json = TicketeSerializer.new(Tickete.last).to_json
      expect(response.body).to eq json
    end

    it "cannot create a tickete with invalid data" do
      params = {
        format: "json",
        tickete: {
          name: "", description: ""
        }
      }
      post api_project_ticketes_path(project, params), params: params, headers: headers

      expect(response.status).to eq 422
      json = {
        "errors" => [
          "Author must exist",
          "Name can't be blank",
          "Description can't be blank",
          "Description is too short (minimum is 10 characters)"
        ]
      }
      expect(JSON.parse(response.body)).to eq json
    end

    context "without permission to view the project" do
      before do
        user.roles.delete_all
      end

      it "responds with a 403" do
        get api_project_tickete_path(project, tickete, format: :json),
          :params => {}, headers: headers
        expect(response.status).to eq 403
        error = { "error" => "Unauthorized" }
        expect(JSON.parse(response.body)).to eq error
      end
    end
  end

  context "as an unauthenticated user" do
    it "responds with a 401" do
      get api_project_tickete_path(project, tickete, format: :json)
      expect(response.status).to eq 401
      error = { "error" => "Unauthorized" }
      expect(JSON.parse(response.body)).to eq error
    end
  end
end