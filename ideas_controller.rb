class Api::V1::IdeasController < ActionController::Base
	respond_to :json
	def index
		respond_with Idea.all.to_a
	end
end
