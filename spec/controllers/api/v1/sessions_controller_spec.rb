require 'rails_helper'

describe API::V1::SessionsController do
  let(:email) { 'test1@mail.net' }
  let(:user) { User.create(email: email, password: '12345678') }
  let(:user_with_api_key) do
    user = User.create(email: email, password: '12345678')
    user.generate_api_key
    user
  end

  it 'success log in user and give api_key' do
    post :log_in, format: :json, email: user.email, password: '12345678'
    expect(JSON.parse(response.body)['api_key']).to eq(user.reload.api_key)
  end

  it 'fail if user not exist or password invalid' do
    post :log_in, format: :json, email: 'abracadabra@no.net', password: '12345678'
    expect(response.status).to eq(401)
  end

  it 'success log out user and remove api_key' do
    get :log_out, format: :json, api_key: user_with_api_key.api_key
    expect(user_with_api_key.reload.api_key).to be_nil
  end

  it 'fail without api_key' do
    get :log_out, format: :json
    expect(response.status).to eq(401)
  end
end
