require "i18n_keys_helper/version"

module I18nKeysHelper

  def set_show_translation_keys
    unless TranslateHelper.is_env_acceptable?
      return
    end
    old_cookie_value=cookies[:show_keys].to_s
    if params[:show_keys]=='true' || (cookies[:show_keys]&&params[:show_keys]!='false')
      cookies[:show_keys]=true
      TranslateHelper.set_show_keys(true)
    else
      cookies.delete :show_keys
      TranslateHelper.set_show_keys(false)
    end
    if cookies[:show_keys].to_s!=old_cookie_value
      params_to_return=params.except(:controller, :action, :show_keys)
      redirect_to "#{request.env['PATH_INFO']}#{params_to_return.any? ? '?' : ''}#{params_to_return.to_query}"
    end
  end

end

require "i18n_keys_helper/engine"
