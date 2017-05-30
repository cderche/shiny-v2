class Users::InvitationsController < Devise::InvitationsController
  layout 'application', only: [:new]

  def after_invite_path_for(resource)
    users_path
  end
end
