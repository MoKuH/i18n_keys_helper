require 'action_view/helpers/tag_helper'
require 'i18n/exceptions'
require 'i18n'

module TranslateHelper
  @show_key=false
  def self.set_show_keys(x)
    @show_key = x
  end

  def self.get_show_keys
    @show_key
  end

  def self.is_env_acceptable?
    !Rails.env.production?
  end

  def self.is_ok(key,options)
    TranslateHelper.is_env_acceptable? && TranslateHelper.get_show_keys
  end

end

module ActionView
  # = Action View Translation Helpers
  module Helpers
    module TranslationHelper
      def translate(key, options={})
        translation=super(key, options.merge(raise: true))
        if  is_trad_array? key
          result=I18n.translate(scope_key_by_partial(key), options,false)
          result_new=Array.new
          result.each do | value|
            if value.nil?
              result_new.push nil
            else
              result_new.push value+ "|#{key}|".html_safe
            end
          end
          return result_new
        else
          translation + "|#{key}|".html_safe
        end
      rescue I18n::MissingTranslationData
        key
      end


      alias :t :translate
      alias :l :localize

      private

      def is_trad_array?(key)
        translations = I18n.backend.send(:translations)
        locale =  @locale || I18n.config.locale
        translations_tmp=translations[locale.to_s]
        if translations_tmp.nil?
          translations_tmp=translations[locale.to_sym]
        end
        translations=translations_tmp
        index=key.to_s.split('.')
        index.each do | value|
          translations=translations[value.to_sym]
          if translations.nil?
            break
          end
        end
        if translations.is_a?(Array)
          true
        else
          false
        end
      end
    end
  end
end

