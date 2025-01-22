require 'rails_helper'

RSpec.describe ScheduleService do
  let(:schedule) { create(:schedule) }
  let(:show) { create(:show) }
  let(:service) { described_class.new(schedule, show) }

  describe "#add_show" do
    context "when the schedule is below MAX_SHOWS" do
      it "adds the show to the schedule" do
        result = service.add_show

        expect(schedule.shows).to include(show)
        expect(result[:status]).to eq(:ok)
        expect(result[:schedule]).to eq(schedule)
      end
    end

    context "when the schedule is at MAX_SHOWS" do
      before do
        create_list(:show, 8, schedules: [schedule])
      end

      it "returns an error" do
        result = service.add_show

        expect(result[:status]).to eq(:unprocessable_entity)
        expect(result[:error]).to eq("Schedule cannot have more than #{ScheduleService::MAX_SHOWS} shows")
      end
    end
  end

  describe "#remove_show" do
    before { schedule.shows << show }

    context "when the show is part of a user's schedule" do
      it "removes the show" do
        result = service.remove_show

        expect(schedule.shows).not_to include(show)
        expect(result[:status]).to eq(:ok)
        expect(result[:schedule]).to eq(schedule)
      end 
    end

    context "when the show is not in the schedule" do
      before {schedule.shows.delete(show) }

      it "returns an error" do
        result = service.remove_show

        expect(result[:status]).to eq(:not_found)
        expect(result[:error]).to eq("Show not found in schedule")
      end
    end
  end
end
