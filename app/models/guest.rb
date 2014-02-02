class Guest < ActiveRecord::Base
    # has_one :group

    before_save { self.email = email.downcase }
    before_create :create_token

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

    private

    def create_token
        self.token = loop do
          token = SecureRandom.urlsafe_base64
          break token unless Guest.exists?(token: token)
        end
    end
end
