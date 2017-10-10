class DashboardsController < ApplicationController
	#before_action :authenticate_user!
	#before_action :set_s3_direct_post, only: [:show]

	def show
		@cards = MtgCard.search({query: {match_all: {}}})
    @react_props = { cards: @cards }
	end

	private
	  # def set_s3_direct_post
	  #   @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
	  # end
end
