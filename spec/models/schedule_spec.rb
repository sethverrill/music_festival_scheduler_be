require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:shows) }
  end
end
