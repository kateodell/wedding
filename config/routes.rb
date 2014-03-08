Wedding::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "public_site#home"

  get 'home' => "public_site#home"
  get 'rsvp' => "public_site#rsvp"
  get 'about_us' => "public_site#about_us"
  get 'details' => "public_site#details"

  post 'rsvp' => "guests#update_rsvp"
  get 'rsvp_confirmation' => 'guests#rsvp_confirmation'
end
