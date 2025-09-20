require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'enums' do
    it 'defines the role enum with string values' do
      should define_enum_for(:role)
        .with_values(user: 'user', contributor: 'contributor', admin: 'admin')
        .backed_by_column_of_type(:string)
        .with_suffix
    end
  end
end
