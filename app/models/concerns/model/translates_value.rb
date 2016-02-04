require 'active_support/concern'

module Concerns
  module Model
    module TranslatesValue
      extend ActiveSupport::Concern

      class_methods do
        def translates_value(*args)
          _ = args.extract_options!

          attributes = args

          attributes.each do |attribute|
            method_name = "translated_#{attribute}"
            define_method method_name do |options = {}|
              translated_value(__method__.to_s.gsub(/^translated_/, ''), options)
            end
          end
        end
      end

      def translated_value(attribute_name, options = {})
        options.reverse_merge!(locale: I18n.locale)
        locale = options.delete(:locale)

        I18n.with_locale(locale) do
          I18n.t("activemodel.values.#{self.class.name.underscore}.#{send(attribute_name).to_s.underscore}")
        end
      end
    end
  end
end