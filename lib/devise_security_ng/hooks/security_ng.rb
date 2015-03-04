Warden::Manager.after_authentication do |user, auth, opts|
  if user.login_attempts>0
    user.login_attempts=0
    user.locked_at=nil
  end
end

