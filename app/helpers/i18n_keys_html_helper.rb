module I18nKeysHtmlHelper
  def render_translate
    if TranslateHelper.is_env_acceptable?
      html_to_render="<script>var module_activated=#{TranslateHelper.get_show_keys}</script>"
      html_to_render << raw(javascript_include_tag('translate'))
      html_to_render << raw(stylesheet_link_tag('translate'))
      html_to_render << "<div id='toggle_show_key' >"
      html_to_render << "<p><a href=\"javascript:location.search+='&show_keys=#{!TranslateHelper.get_show_keys}';\">Click here to #{TranslateHelper.get_show_keys ? 'stop displaying' : 'display'} translation keys</a></p>"
      html_to_render << "</div>"
      raw html_to_render
    end
  end
end


