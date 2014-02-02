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
        context 'when the user has a token' do
            it "should have the right content" do
              visit '/rsvp'
              expect(page).to have_content('This is the place where people')
            end
        end

        context "when the user does not have a valid token" do
            it 'should show the message to have them check their email' do |variable|
                expect(page).to have_content('Check your email')
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
