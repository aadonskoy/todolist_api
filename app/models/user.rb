class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks, dependent: :destroy

  scope :by_token, -> (token) { where(api_key: token) }

  def generate_api_key
    begin
      secure_key = SecureRandom.hex
    end while User.where(api_key: secure_key).present?
    update_attribute(:api_key, secure_key)
    return secure_key
  end

  def destroy_token
    update_attribute(:api_key, nil)
  end
end
