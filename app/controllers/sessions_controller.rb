class SessionsController < ApplicationController
 
	def create
	  user_password = params[:session][:password]
	  user_email = params[:session][:email]

	  unless user_email.present? and user_password.present?
	    render json: {errors:  "Invalid parameters, session[email] and session[password] should be present"}, 
	    status: 422 
	  else
	    user = User.find_by(email: user_email)
		    if user.nil?
		      render json: { errors: "Invalid email" }, status: 404 
		    elsif user.valid_password? user_password
		      sign_in user, store: false
		      user.generate_authentication_token!
		      user.save
		      render json: user, status: 200
		    else 
		      render json: { errors: "Password invalid" }, status: 422 
		    end
		end
	end

	def destroy
		current_user.generate_authentication_token!
		current_user.save
		render json: {"message":"Gracias por preferirnos"}, status: 200
	end
end