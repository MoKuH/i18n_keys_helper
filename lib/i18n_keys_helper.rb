require "i18n_keys_helper/version"

module I18nKeysHelper

  def set_show_translation_key
    if params[:show_key]=='true' && !is_production || (session[:show_key] && params[:show_key]!='false'  )
      session[:show_key]=true
      TranslateHelper.set_show_key(true)
    else
      session[:show_key]=false
      TranslateHelper.set_show_key(false)
    end
  end

end

require "i18n_keys_helper/engine"
