require 'spec_helper'

describe "Public site pages" do
    describe "Home page" do
        it "should have the right content'" do
            visit '/home'
            expect(page).to have_content('Please')
        end
    end

    describe "Details page" do
        it "should have the right contet" do
          visit '/details.html'
          expect(page).to have_content('Friday Night Dinner')
        end
    end

    describe "RSVP page" do
        before do
            guest = Guest.new(first_name: "Fred", last_name: "Flinstone", email: "user@example.com")
            guest.save   
            guest.token = "abc123"
            guest.save
        end

        context 'when the user has a valid token' do
            it "should have the right content" do
                visit '/rsvp?token=abc123'
                expect(page).to have_content('Fred')
            end
        end

        context 'when the user has a token that is not valid' do
            it "should have the right content" do
                visit '/rsvp?token=not_a_token'
                expect(page).to have_content('click on the RSVP link from the email')
            end
        end

        context "when the user does not have a token" do
            it 'should show the message to have them check their email' do
                visit '/rsvp'
                expect(page).to have_content('click on the RSVP link from the email')
            end
            
        end
    end

    describe "About page" do
        it "should have the right contet" do
          visit '/about_us'
          expect(page).to have_content('A Brief History of Kate')
        end
    end

end
