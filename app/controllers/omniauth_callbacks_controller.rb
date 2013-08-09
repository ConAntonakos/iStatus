class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	# def twitter
	# 	auth = env["omniauth.auth"]
	# 	@user = user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])	|| User.new
	# 	if @user.persisted?
	# 		flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
	# 		sign_in_and_redirect @user, :event => :authentication
	# 	else
	# 		session["devise.twitter_uid"] = auth["uid"]
	# 		redirect_to new_user_registration_url
	# 	end
	# end

end
