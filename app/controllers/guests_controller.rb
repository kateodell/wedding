class GuestsController < ApplicationController
    def show

    end

    private
    def guest_params
        params.require(:email).permit(:name, :rsvp_status, :rehearsal_rsvp)
    end
end