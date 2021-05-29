class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :facebook

  def facebook
    oauth_user(__callee__)
  end

  def vkontakte
    oauth_user(__callee__)
  end

  private

  def oauth_user(provider)
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.to_s)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: provider.to_s,
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
end
