class Citizens::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @citizen = Citizen.find_for_facebook_auth(request.env["omniauth.auth"])
    
    if @citizen
      KM.identify(@citizen)
      KM.push("record", "Facebook login")
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Facebook"
      sign_in_and_redirect @citizen, event: :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      # Meta refresh. 301 redirect can't be used, because the web browser
      # wouldn't display the intermediate page at all and the citizen would be
      # looking at nothing for nearly 30 seconds.
      response.headers["Refresh"] = "1;URL=" + citizen_register_with_facebook_url
    end
  end
end
