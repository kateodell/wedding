class Guest < ActiveRecord::Base
    has_one :group

    attr_accessible :phone, 
                    :contact_preference, 
                    :mailing_address, :city, :state, :zip, 
                    :group_id, 
                    :rsvp_status, :rehearsal_status, 

    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
