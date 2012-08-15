require 'spec_helper'

describe CitizensController do
  let (:citizen) {
    Factory :citizen
  }

  get :edit do
    before do
      sign_in citizen
    end
    action! do
      it "assigns the citizen as @citizen" do
        assigns(:citizen).should == citizen
      end
    end
  end
  
  post :update do
    context "with the right password" do
      params {{:citizen => {
            :current_password => citizen.password,
            :password => "",
            :password_confirmation => "",
            :email => "citizen@example.com"
          }}}
      it "logged in" do
        sign_in citizen
        action! do
          citizen.reload
          citizen.email.should == "citizen@example.com"
        end
      end
      it "as anonymous user" do
        original_citizen = citizen.dup
        action! do
          citizen.reload
          citizen.attributes.should == original_citizen.attributes
        end
      end
    end
    context "with a wrong password" do
      params {{:citizen => {
            :current_password => "wrong password",
            :password => "",
            :password_confirmation => "",
            :email => "citizen@example.com"
          }}}
      it "logged in" do
        original_citizen = citizen.dup
        sign_in citizen
        action! do
          citizen.reload
          citizen.attributes.should == original_citizen.attributes
        end
      end
    end
  end
  
  get :register_with_facebook do    
    it "should create a new citizen and a new authentication" do
      session["devise.facebook_data"] = auth_hash
      lambda {
        lambda {
          action!
        }.should change(Citizen, :count).by(1)
      }.should change(Authentication, :count).by(1)
      controller.citizen_signed_in?.should be_true
      response.should redirect_to(root_path)
    end
  end

end
