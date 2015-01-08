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
    missing=false
    if TranslateHelper.is_env_acceptable? && TranslateHelper.get_show_keys
      raise I18n::ArgumentError if key.is_a?(String) && key.empty?
      begin
        I18n.translate!(key,options)
      rescue I18n::MissingTranslationData
        missing=true
      end
    end

    TranslateHelper.is_env_acceptable? && TranslateHelper.get_show_keys && !missing
  end

end
module I18n
  class MissingTranslation
    module Base
      attr_reader :locale, :key, :options

      def initialize(locale, key, options = nil)
        @key, @locale, @options = key, locale, options.dup || {}
        options.each { |k, v| self.options[k] = v.inspect if v.is_a?(Proc) }
      end

      def html_message
        if Rails.env.production?
          ''
        else
          key  = CGI.escapeHTML titleize(keys.last)
          path = CGI.escapeHTML keys.join('.')
          %(<span class="translation_missing" title="translation missing: #{path}">#{key}</span>)
        end
      end
    end
  end

  extend(Module.new {
    def translate(key, options = {},show_key=true)
      translation=super(key, options)
      if show_key  && TranslateHelper.is_ok(key,options) && !translation.is_a?(Hash)
        if options[:scope].nil?
          scope=''
        else
          scope=options[:scope]+"."
        end
        key=scope+key.to_s.gsub(/\./,'--')
        translation="#{translation}|#{key}|".html_safe
      end
      translation
    end
    def translate!(key, options={},show_key=false)
      I18n.translate(key, options.merge(:raise => true),show_key)
    end

  })
end
module ActionView
  # = Action View Translation Helpers
  module Helpers
    module TranslationHelper


      def translate(key, options = {})
        if TranslateHelper.is_ok(key,options)
          options.merge!(:rescue_format => :html) unless options.key?(:rescue_format)
          if html_safe_translation_key?(key)
            html_safe_options = options.dup
            options.except(*I18n::RESERVED_KEYS).each do |name, value|
              unless name == :count && value.is_a?(Numeric)
                html_safe_options[name] = ERB::Util.html_escape(value.to_s)
              end
            end
            translation = I18n.translate(scope_key_by_partial(key), html_safe_options,false)

            return translation.respond_to?(:html_safe) ? translation.html_safe : translation
          else
            if options[:scope].nil?
              scope=''
            else
              scope=options[:scope]+"."
            end
            show_key=scope+key.to_s.gsub(/\./,'--')


            if  is_trad_array? key
              result=I18n.translate(scope_key_by_partial(key), options,false)
              result_new=Array.new
              result.each do | value|
                if value.nil?
                  result_new.push nil
                else
                  result_new.push value+ "|#{show_key}|".html_safe
                end
              end
              return result_new
            else
              return I18n.translate(scope_key_by_partial(key), options,false)+ "|#{show_key}|".html_safe
            end
          end

        else
          options.merge!(:rescue_format => :html) unless options.key?(:rescue_format)
          if html_safe_translation_key?(key)
            html_safe_options = options.dup
            options.except(*I18n::RESERVED_KEYS).each do |name, value|
              unless name == :count && value.is_a?(Numeric)
                html_safe_options[name] = ERB::Util.html_escape(value.to_s)
              end
            end

            translation = I18n.translate(scope_key_by_partial(key), html_safe_options,false)

            translation.respond_to?(:html_safe) ? translation.html_safe : translation
          else
            I18n.translate(scope_key_by_partial(key), options,false)
          end
        end
      end
      alias :t :translate
      alias :l :localize

      private

      def is_trad_array?(key)
        translations = I18n.backend.send(:translations)
        locale =  @locale || I18n.config.locale
        translations=translations[locale]

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
