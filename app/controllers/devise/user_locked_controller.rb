class Devise::UserLockedController < DeviseController
    prepend_before_action :require_no_authentication

    def show
        if not params[:unlock_token].empty?
            unlock_token_digest = Devise.token_generator.digest(self, :unlock_token, params[:unlock_token])
            @user = User.find_by_unlock_token(unlock_token_digest)
            if @user
                @user.locked_at = nil
                @user.unlock_token = nil
                @user.save!

                redirect_to new_user_session_path, :notice => I18n.t('unlocked', {:scope => 'devise.success'}) and return
            end
        end
        redirect_to new_user_session_path
    end
end
