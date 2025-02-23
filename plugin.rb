# frozen_string_literal: true

# name: discourse-naver-auth
# about: Allows users to login using Naver authentication.
# version: 1.0
# authors: sleepinglion
# url: https://github.com/centromics-forum/discourse-naver-auth

gem 'omniauth-naver','0.2.0'

register_svg_icon "naver"

enabled_site_setting :enable_naver_logins

class NaverAuthenticator < Auth::ManagedAuthenticator
  AVATAR_SIZE ||= 480

  def name
    "naver"
  end

  def enabled?
    SiteSetting.enable_naver_logins
  end

  def register_middleware(omniauth)
    omniauth.provider :naver,
                      setup:
                        lambda { |env|
                          strategy = env["omniauth.strategy"]
                          strategy.options[:client_id] = SiteSetting.naver_client_id
                          strategy.options[:client_secret] = SiteSetting.naver_secret
                        }
  end

  # facebook doesn't return unverified email addresses so it's safe to assume
  # whatever email we get from them is verified
  # https://developers.facebook.com/docs/graph-api/reference/user/
  def primary_email_verified?(auth_token)
    true
  end
end

auth_provider  icon: "naver", authenticator: NaverAuthenticator.new
