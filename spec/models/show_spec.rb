require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:time_slot) }
  end

  describe 'associationns' do
    it { should belong_to(:artist) }
    it { should belong_to(:venue) }
    it { should belong_to(:schedule) }
  end
end
