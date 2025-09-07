# == Schema Information
#
# Table name: author_refs
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AuthorRef < ApplicationRecord
  has_and_belongs_to_many :bibliographic_references
end
