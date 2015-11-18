class RegistrationsController < Devise::RegistrationsController
	private

	def sign_up_params
		params.require(:user).permit(:name, :surname, :phoneWork, :phoneMob, :email, :password, :password_confirmation, :confirmed_at)
	end
	def account_update_params
		params.require(:user).permit(:name, :surname, :phoneWork, :phoneMob, :email, :password, :password_confirmation, :current_password, :confirmed_at)
	end
	def after_sign_up_path_for(resource)
		'catalog/root'
	end
end