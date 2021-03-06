class GuestsController < ApplicationController
    def show(token)
        Guest.find_by_token(params[token])
    end

    def update_rsvp
        @rsvping_guest = Guest.find(params['rsvping_guest'])
        guests_in_group = @rsvping_guest.rsvp_info
        guests_in_group.each do |guest|
            guest.update_rsvp(params["friday_#{guest.id}"], params["saturday_#{guest.id}"], params['dietary_notes'], params['other_notes'])
        end
        @rsvp_info = @rsvping_guest.rsvp_info
        InvitationMailer.send_confirmation_email(@rsvping_guest)
        render template: 'public_site/rsvp_confirmation'
    end

    private
    def guest_params
        params.require(:email).permit(:name, :saturay_rsvp, :friday_rsvp, :last_invite_emailed)
    end
end
