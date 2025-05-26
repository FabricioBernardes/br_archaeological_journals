class AuthorRef < ApplicationRecord
  has_and_belongs_to_many :bibliographic_references
end
