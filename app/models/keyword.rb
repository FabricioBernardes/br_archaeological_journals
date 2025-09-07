# == Schema Information
#
# Table name: keywords
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Keyword < ApplicationRecord
  has_and_belongs_to_many :articles
end
