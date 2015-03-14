require 'rails_helper'

describe API::V1::TasksController do
  let(:email) { 'test_mail@mail.net' }
  let!(:user_with_api_key) do
    user = User.create(email: email, password: '12345678')
    user.generate_api_key
    user
  end

  let!(:task_noise) do
    2.times do |i|
      Task.create(time: DateTime.current + i.days,
                  description: "text for task #{i}",
                  status: "status of task #{i}")
    end
  end

  let!(:five_tasks) do
    5.times do |i|
      Task.create(time: DateTime.current + i.days,
                  description: "text for task #{i}",
                  status: "status of task #{i}",
                  user_id: user_with_api_key.id)
    end
  end

  let(:task) do
    Task.create(time: DateTime.current,
                description: "selected task",
                status: "status of selected",
                user_id: user_with_api_key.id)
  end

  it 'show 5 tasks for logged in user' do
    get :index, format: :json, api_key: user_with_api_key.api_key
    expect(JSON.parse(response.body).count).to eq(5)
  end

  it 'show selected task for user with api' do
    get :show, format: :json, id: task.id, api_key: user_with_api_key.api_key
    expect(JSON.parse(response.body)['id']).to eq(task.id)
  end

  it 'success create new task for current user' do
    expect do
      post :create,
           format: :json,
           api_key: user_with_api_key.api_key,
           time: DateTime.current,
           description: 'new task',
           status: 'status of the new task'
     end.to change(user_with_api_key.reload.tasks, :count).from(5).to(6)
  end

  it 'delete task for user with api' do
    task
    expect do
      get :destroy, format: :json, id: task.id, api_key: user_with_api_key.api_key
    end.to change(user_with_api_key.reload.tasks, :count).from(6).to(5)
  end

  it 'update selected task for the user with api key' do
    task
    patch :update, format: :json, id: task.id, api_key: user_with_api_key.api_key, description: 'updated text'
    expect(task.reload.description).to eq('updated text')
    expect(JSON.parse(response.body)['description']).to eq('updated text')
  end
end
