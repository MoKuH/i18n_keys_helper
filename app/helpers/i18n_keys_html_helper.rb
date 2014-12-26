module I18nKeysHtmlHelper
  def render_translate
    if TranslateHelper.is_env_acceptable?
      html_to_render=''
      html_to_render << raw(javascript_include_tag('translate'))
      html_to_render << "<div id='toggle_show_key' style='padding:10px;z-index:100;opacity=0.6;width:100px;height:100px;position:fixed;top:10%;right:0;background:#dedede;-webkit-border-top-left-radius: 8px;-webkit-border-bottom-left-radius: 8px;-moz-border-radius-topleft: 8px;-moz-border-radius-bottomleft: 8px;border-top-left-radius: 8px; border-bottom-left-radius: 8px;'>"
      html_to_render << "<p><a href=\"javascript:location.search+='&show_keys=#{!TranslateHelper.get_show_keys}';\">Click here to #{TranslateHelper.get_show_keys ? 'stop displaying' : 'display'} translation keys</a></p>"
      html_to_render << "</div>"
      raw html_to_render
    end
  end
end


