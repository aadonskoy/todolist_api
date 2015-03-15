require 'rails_helper'

describe API::V1::RegistrationsController do
  let(:email) { 'test@mail.net' }
  it 'log_in create new user with empty api_key' do
    post :create, format: :json, email: email, password: '12345678'
    expect(User.find_by_email(email).api_key).to be_nil
  end

  it 'cause error with wrong data' do
    post :create, format: :json, email: email, password: '123'
    expect(response.status).to eq(422)
  end
end
