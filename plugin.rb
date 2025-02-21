# frozen_string_literal: true

# name: discourse-naver-auth
# about: Allows users to login using Naver authentication.
# version: 1.0
# authors: sleepinglion
# url: https://github.com/centromics-forum/discourse-naver-auth

enabled_site_setting :sign_in_with_naver_enabled

class NaverAuthenticator < ::Auth::ManagedAuthenticator
  def name
    "naver"
  end

  def enabled?
    SiteSetting.sign_in_with_naver_enabled?
  end

  # apple requires email verification to create an account so we can assume
  # email is verified
  def primary_email_verified?(auth_token)
    true
  end
end

