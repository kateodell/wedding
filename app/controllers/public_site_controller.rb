class PublicSiteController < ApplicationController
  def home
  end

  def rsvp
    if params[:token] && Guest.find_by_token(params[:token])
        @guest = Guest.find_by_token(params[:token])
        # @group_info = @guest.group_info
    else
        render template: 'public_site/rsvp_no_token'
    end
  end

  def about_us
  end

  def details
  end
end
