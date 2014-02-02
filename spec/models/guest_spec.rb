require 'spec_helper'

describe Guest do
    before { 
        @guest = Guest.new(first_name: "Fred", last_name: "Flinstone", email: "user@example.com")
    }

    subject { @guest }

    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:token) }

    it { should be_valid }
    
end