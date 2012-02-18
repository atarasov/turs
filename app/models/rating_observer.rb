class RatingObserver < ActiveRecord::Observer
	observe :user, :photo, :video, :comment, :pro_account, :link_to_site, :recommended_service, :in_site_service,
			:journal_service, :selection_service

	def after_save(model)
		update_user_rating(model)
	end

	def after_destroy(model)
		update_user_rating(model)
	end

	private

	def update_user_rating(model)
		if model.class.name.eql?"User"
			model.update_rating
		else
			if model.user.present?
				model.user.update_rating
			end
		end
	end
end
