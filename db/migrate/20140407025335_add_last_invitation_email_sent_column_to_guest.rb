class AddLastInvitationEmailSentColumnToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :last_invite_emailed, :datetime
  end
end
