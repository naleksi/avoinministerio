class CitizensController < ApplicationController
  before_filter :authenticate_citizen!, :except => [:register_with_facebook]
  before_filter :fetch_citizen, :except => [:register_with_facebook]
  
  def edit
  end
  
  # based on https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password
  def update
    if @citizen.update_with_password(params[:citizen])
      flash[:notice] = I18n.t("registrations.edit.password_updated")
      sign_in @citizen, :bypass => true
    end
    render "edit"
  end
  
  def register_with_facebook
    @citizen = Citizen.build_from_auth_hash(session["devise.facebook_data"])
    if @citizen.persisted?
      KM.identify(@citizen)
      KM.push("record", "Facebook registration")
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Facebook"
      sign_in_and_redirect @citizen, event: :authentication
    else
      redirect_to new_citizen_registration_url
    end
  end
  
  private
  
  def fetch_citizen
    @citizen = current_citizen
  end

end
