class PublicSiteController < ApplicationController
  def home
  end

  def rsvp
    params[:token] ||= session[:token]
    if params[:token] && Guest.find_by_token(params[:token])
        session[:token] = params[:token]
        @guest = Guest.find_by_token(params[:token])
        @rsvp_info = @guest.rsvp_info
    else
        render template: 'public_site/rsvp_no_token'
    end
  end

  def about_us
  end

  def details
  end
end
