class Guest < ActiveRecord::Base

    RSVP_EMPTY = ''
    RSVP_NO = 'no'
    RSVP_MAYBE = 'maybe'
    RSVP_YES = 'yes'

    RSVP_RESPONSE_TEXT = {
        RSVP_EMPTY => 'Not Yet Responded',
        RSVP_NO => 'Not Attending',
        RSVP_MAYBE => 'Maybe',
        RSVP_YES => 'Attending'
    }

    before_save { self.email = email.downcase }
    before_create :create_token

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

    has_many :guests, :class_name => 'Guest', :foreign_key => 'group_leader'

    def rsvp_info
        if self.group_leader.nil?
            Guest.where(group_leader: self.id) << self
        else
            #TODO: make sure this can't have duplicates if the group leader has itself as group_leader (do in one query?)
            Guest.where(group_leader: self.group_leader) << Guest.find_by_id(self.group_leader)
        end
    end

    def update_rsvp(friday_rsvp, saturday_rsvp, dietary_notes, other_notes)
        self.saturday_rsvp = saturday_rsvp
        self.friday_rsvp = friday_rsvp
        self.dietary_notes = dietary_notes
        self.other_notes = other_notes
        self.save!
    end

    def friday_rsvp_text
        return 'Not Yet Responded' if self.friday_rsvp.nil?
        RSVP_RESPONSE_TEXT[self.friday_rsvp]
    end

    def saturday_rsvp_text
        return 'Not Yet Responded' if self.saturday_rsvp.nil?
        RSVP_RESPONSE_TEXT[self.saturday_rsvp]
    end

    private

    def create_token
        self.token = loop do
          token = SecureRandom.urlsafe_base64
          break token unless Guest.exists?(token: token)
        end
    end
end
