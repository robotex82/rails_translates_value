require 'active_support/concern'

module Concerns
  module Model
    module TranslatedAttrAccessor
      extend ActiveSupport::Concern

      class_methods do
        def translated_attr_accessor(*args)
          _ = args.extract_options!

          attributes = args

          attributes.each do |attribute|
            I18n.available_locales.each do |locale|
              reader_method_name = "#{attribute}_#{locale}"
              writer_method_name = "#{attribute}_#{locale}="

              define_method attribute do |locale = I18n.locale|
                name = __method__
                key  = read_attribute(:identifier)
                read_translated_attribute(name, key, locale)
              end

              define_method reader_method_name do
                locale = __method__.to_s.split("_").last
                name = __method__.to_s.gsub("_#{locale}", '')
                key = read_attribute(:identifier)
                read_translated_attribute(name, key, locale)
              end

              define_method writer_method_name do |value|
                locale = __method__.to_s.split("_").last.gsub("=", '')
                name   = __method__.to_s.gsub("_#{locale}=", "")
                key = read_attribute(:identifier)
                write_translated_attribute(name, key, value, locale)
              end
            end
          end
        end
      end

      # private

      def write_translated_attribute(name, key, value, locale)
        key = "activerecord.values.#{self.class.name.underscore}.#{name}.#{key}"
        Ecm::Translations::Translation.where(locale: locale, key: key).first_or_initialize.update_attribute(:value, value)
        I18n.reload!
        value
      end

      def read_translated_attribute(name, key, locale)
        I18n.with_locale(locale) do
          I18n.t("activerecord.values.#{self.class.name.underscore}.#{name}.#{key}", default: '')
        end
      end
    end
  end
end