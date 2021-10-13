class User < ApplicationRecord


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :products


  # def self.authenticate(email, password)
  #   user = User.find_for_authentication(email: email)
  #   user&.valid_password?(password) ? user : nil
  # end

  def self.create_new_user(email, password)
    user = User.new({ :email => email, :password => password })
    return user.save
  end

end
