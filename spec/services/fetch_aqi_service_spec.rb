require 'rails_helper'

RSpec.describe FetchAqiService, type: :service do

  let!(:city) {create(:city)}

  let(:service_params) do
    { city: city }
  end

  def initialize_service_object(service_params)
    @service_object = described_class.new(service_params)
  end


  context "When given city has valid co-ordinates" do
    it 'Correctly returns response with 200' do
      initialize_service_object(service_params)
      expect(@service_object.response_payload).to eql(nil)
      resp = @service_object.call
      expect(resp).to eql(true)
      expect(@service_object.response_payload).to be_a HTTParty::Response
      expect(@service_object.error_message).to eql(nil)
      expect(@service_object.response_payload.keys).to eql(["coord", "list"])
      expect(@service_object.response_payload.code).to eql(200)
    end
  end

  context "When given city has invlaid co-ordinates" do
    it 'Returns an error message' do
      city.update latitude: nil, longitude: nil
      initialize_service_object(service_params)
      expect(@service_object.response_payload).to eql(nil)
      resp = @service_object.call
      expect(resp).to eql(false)
      expect(@service_object.response_payload).to eql(nil)
      expect(@service_object.error_message).to eql("Nothing to geocode")
    end
  end
end
