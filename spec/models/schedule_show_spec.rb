RSpec.describe ScheduleShow, type: :model do
  describe 'associations' do
    it { should belong_to(:schedule) }
    it { should belong_to(:show) }
  end
end
