# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true

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
