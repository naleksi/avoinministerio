object @idea
attributes :id, :title, :summary, :body, :state, :author_id, :created_at, :updated_at, :publish_state, :slug
node :user_voted do |idea|
	idea.voted_by?(current_citizen)
end
node :user_vote do |idea|
	idea.votes.by(current_citizen).first
end
