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
        it "should have the right contet" do
          visit '/rsvp'
          expect(page).to have_content('Hold your horses!')
      end
    end

    describe "About page" do
        it "should have the right contet" do
          visit '/about_us'
          expect(page).to have_content('A Brief History of Kate')
      end
    end

end
