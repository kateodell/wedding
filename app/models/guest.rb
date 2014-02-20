class Guest < ActiveRecord::Base
    RSVP_RESPONSE = {
        'no_response' => 0,
        'no' => 1,
        'maybe' => 2,
        'yes' => 3
    }

    RSVP_RESPONSE_TEXT = [
        'Not Yet Responded',
        'Not Attending',
        'Maybe',
        'Attending'
    ]

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

    def update_rsvp(rehearsal_status, rsvp_status, dietary_notes, other_notes)
        self.rsvp_status = RSVP_RESPONSE[rsvp_status]
        self.rehearsal_status = RSVP_RESPONSE[rehearsal_status]
        self.dietary_notes = dietary_notes
        self.other_notes = other_notes
        self.save!
    end

    def rehearsal_status_key
        return '' if self.rehearsal_status.nil?
        RSVP_RESPONSE.keys[self.rehearsal_status]
    end

    def rsvp_status_key
        return '' if self.rsvp_status.nil?
        RSVP_RESPONSE.keys[self.rsvp_status]
    end

    def rehearsal_status_text
        return 'Not Yet Responded' if self.rehearsal_status.nil?
        RSVP_RESPONSE_TEXT[self.rehearsal_status]
    end

    def rsvp_status_text
        return 'Not Yet Responded' if self.rsvp_status.nil?
        RSVP_RESPONSE_TEXT[self.rsvp_status]
    end

    private

    def create_token
        self.token = loop do
          token = SecureRandom.urlsafe_base64
          break token unless Guest.exists?(token: token)
        end
    end
end
