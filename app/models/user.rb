class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 'user', contributor: 'contributor', admin: 'admin' }, _suffix: true

  def admin?
    role == 'admin'
  end

  def contributor?
    role == 'contributor' || admin?
  end

  def user?
    role == 'user' || contributor || admin?
  end
end
