require 'rails_helper'

describe API::V2::Ticketes do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:tickete) { FactoryBot.create(:tickete, project: project, author: user) }
  let(:url) { "/api/v2/projects/#{project.id}/ticketes/#{tickete.id}" }

  let(:headers) do
    { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}"}
  end

  before do
    assign_role!(user, :manager, project)
    user.generate_api_key
  end

  context "successful requests" do
    it "can view a tickete's details" do
      get url, params: {}, headers: headers

      expect(response.status).to eq 200
      json = TicketeSerializer.new(tickete).to_json
      expect(response.body).to eq json
    end
  end

  context "unsuccessful requests" do
    it "doesn't allow requests that don't pass through an API key" do
      get url
      expect(response.status).to eq 401
      expect(response.body).to include "Unauthenticated"
    end
    
    it "doesn't allow requests that pass an invalid API key" do
      get url, params: {}, headers: { "HTTP_AUTHORIZATION" => "Token token=notavalidkey"}
      expect(response.status).to eq 401
      expect(response.body).to include "Unauthenticated"
    end

    it "doesn't allow access to a tickete that the user doesn't have permission to read" do
      project.roles.delete_all
      get url, params: {}, headers: headers
      expect(response.status).to eq 404
    end
  end
end