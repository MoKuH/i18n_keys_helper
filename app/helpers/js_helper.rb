module JsHelper
  def render_trad_js
    if TranslateHelper.get_show_key
      javascript_include_tag 'translate'
    end
  end
end