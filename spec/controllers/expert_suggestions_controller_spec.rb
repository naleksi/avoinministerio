require 'spec_helper'

describe ExpertSuggestionsController do

  before :each do
    @citizen = Factory.create :citizen
    sign_in @citizen
    @idea = Factory :idea
    @valid_attributes = {
        firstname: 'Erkki',
        lastname: 'Esimerkki',
        email: 'erkki@asiantuntija.fi',
        jobtitle: 'Asiantuntija',
        organisation: 'Asiantuntijat Oy',
        expertise: '',
        recommendation: ''
      }
  end

  describe "POST create" do
    it "creates a new ExpertSuggestion" do
      expect {
        post :create, { idea_id: @idea.id, expert_suggestion: @valid_attributes }
      }.to change(ExpertSuggestion, :count).by(1)
    end

    it "assigns a newly created expert_suggestion as @expert_suggestion" do
      post :create, { idea_id: @idea.id, expert_suggestion: @valid_attributes }
      assigns(:expert_suggestion).should be_a(ExpertSuggestion)
      assigns(:expert_suggestion).should be_persisted
    end

    it "redirects to the created expert_suggestion" do
      post :create, { idea_id: @idea.id, expert_suggestion: @valid_attributes }
      response.should redirect_to(ExpertSuggestion.last.idea)

  # This should return the minimal set of attributes required to create a valid
  # ExpertSuggestion. As you add validations to ExpertSuggestion, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ExpertSuggestionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all expert_suggestions as @expert_suggestions" do
      expert_suggestion = ExpertSuggestion.create! valid_attributes
      get :index, {}, valid_session
      assigns(:expert_suggestions).should eq([expert_suggestion])
    end
  end

  describe "GET show" do
    it "assigns the requested expert_suggestion as @expert_suggestion" do
      expert_suggestion = ExpertSuggestion.create! valid_attributes
      get :show, {:id => expert_suggestion.to_param}, valid_session
      assigns(:expert_suggestion).should eq(expert_suggestion)
    end
  end

  describe "GET new" do
    it "assigns a new expert_suggestion as @expert_suggestion" do
      get :new, {}, valid_session
      assigns(:expert_suggestion).should be_a_new(ExpertSuggestion)
    end
  end

  describe "GET edit" do
    it "assigns the requested expert_suggestion as @expert_suggestion" do
      expert_suggestion = ExpertSuggestion.create! valid_attributes
      get :edit, {:id => expert_suggestion.to_param}, valid_session
      assigns(:expert_suggestion).should eq(expert_suggestion)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ExpertSuggestion" do
        expect {
          post :create, {:expert_suggestion => valid_attributes}, valid_session
        }.to change(ExpertSuggestion, :count).by(1)
      end

      it "assigns a newly created expert_suggestion as @expert_suggestion" do
        post :create, {:expert_suggestion => valid_attributes}, valid_session
        assigns(:expert_suggestion).should be_a(ExpertSuggestion)
        assigns(:expert_suggestion).should be_persisted
      end

      it "redirects to the created expert_suggestion" do
        post :create, {:expert_suggestion => valid_attributes}, valid_session
        response.should redirect_to(ExpertSuggestion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expert_suggestion as @expert_suggestion" do
        ExpertSuggestion.any_instance.stub(:save).and_return(false)
        post :create, { idea_id: @idea.id, expert_suggestion: {} }
        assigns(:expert_suggestion).should be_a_new(ExpertSuggestion)
      end

      it "re-renders the 'new' template" do
        ExpertSuggestion.any_instance.stub(:save).and_return(false)
        post :create, { idea_id: @idea.id, expert_suggestion: {} }
        response.should render_template("new")
      end
    end

    describe "no citizen logged in" do
      before :each do
        sign_out @citizen
      end

      it "should authenticate citizen" do
        post :create, { idea_id: @idea.id, expert_suggestion: @valid_attributes }
        response.should_not be_success
        response.should redirect_to(new_citizen_session_path)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested expert_suggestion" do
        expert_suggestion = ExpertSuggestion.create! valid_attributes
        # Assuming there are no other expert_suggestions in the database, this
        # specifies that the ExpertSuggestion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ExpertSuggestion.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => expert_suggestion.to_param, :expert_suggestion => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested expert_suggestion as @expert_suggestion" do
        expert_suggestion = ExpertSuggestion.create! valid_attributes
        put :update, {:id => expert_suggestion.to_param, :expert_suggestion => valid_attributes}, valid_session
        assigns(:expert_suggestion).should eq(expert_suggestion)
      end

      it "redirects to the expert_suggestion" do
        expert_suggestion = ExpertSuggestion.create! valid_attributes
        put :update, {:id => expert_suggestion.to_param, :expert_suggestion => valid_attributes}, valid_session
        response.should redirect_to(expert_suggestion)
      end
    end

    describe "with invalid params" do
      it "assigns the expert_suggestion as @expert_suggestion" do
        expert_suggestion = ExpertSuggestion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ExpertSuggestion.any_instance.stub(:save).and_return(false)
        put :update, {:id => expert_suggestion.to_param, :expert_suggestion => {}}, valid_session
        assigns(:expert_suggestion).should eq(expert_suggestion)
      end

      it "re-renders the 'edit' template" do
        expert_suggestion = ExpertSuggestion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ExpertSuggestion.any_instance.stub(:save).and_return(false)
        put :update, {:id => expert_suggestion.to_param, :expert_suggestion => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested expert_suggestion" do
      expert_suggestion = ExpertSuggestion.create! valid_attributes
      expect {
        delete :destroy, {:id => expert_suggestion.to_param}, valid_session
      }.to change(ExpertSuggestion, :count).by(-1)
    end

    it "redirects to the expert_suggestions list" do
      expert_suggestion = ExpertSuggestion.create! valid_attributes
      delete :destroy, {:id => expert_suggestion.to_param}, valid_session
      response.should redirect_to(expert_suggestions_url)
    end
  end
end
