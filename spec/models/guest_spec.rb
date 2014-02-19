require 'spec_helper'

describe Guest do
    before { 
        @guest = Guest.new(first_name: "Fred", last_name: "Flinstone", email: "user@example.com", group_leader: 2)
        @guest.save!
    }

    subject { @guest }

    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:token) }

    it { should be_valid }

    describe '#rsvp_info' do

        it 'should return an array of guests with the same group leader including the leader' do
            guest2 = Guest.new(first_name: "Wilma", last_name: "Flinstone", email: "wilma@example.com")
            guest2.save!
            guest3 = Guest.new(first_name: "BamBam", last_name: "Flinstone", email: "bambam@example.com", group_leader: 2)
            guest3.save!
            @guest.rsvp_info.should match_array([@guest, guest2, guest3])
        end

        context 'when the group_leader is empty' do
            it 'returns an array of itself and guests who have it as group leader' do
                @guest2 = Guest.new(first_name: "Barney", last_name: "Rubble", email: "barney@example.com", group_leader: 3)
                @guest2.save!
                guest3 = Guest.new(first_name: "Betty", last_name: "Rubble", email: "betty@example.com", id: 3)
                guest3.save!

                guest3.rsvp_info.should match_array([guest3, @guest2])
            end
        end
    end
    
end