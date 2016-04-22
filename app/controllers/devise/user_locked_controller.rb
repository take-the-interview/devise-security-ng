class Devise::UserLockedController < DeviseController
    prepend_before_filter :require_no_authentication

    def show
        if not params[:unlock_token].empty?
            @user = User.find_by_unlock_token(params[:unlock_token])
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
