module Shoulda
  module Matchers
    module ActiveModel
      module NumericalityMatchers
        # @private
        class OnlyFloatMatcher < NumericTypeMatcher
          NON_FLOAT_VALUE = 1

          def simple_description
            description = ''

            if expects_strict?
              description << ' strictly'
            end

            description + "disallow :#{attribute} from being a decimal number"
          end

          def allowed_type_name
            'float'
          end

          def diff_to_compare
            0.1
          end

          private

          def given_numeric_column?
            attribute_is_active_record_column? && column_type == :float
          end

          protected

          def wrap_disallow_value_matcher(matcher)
            matcher.with_message(:not_an_integer)
          end

          def disallowed_value
            if @numeric_type_matcher.given_numeric_column?
              NON_FLOAT_VALUE
            else
              NON_FLOAT_VALUE.to_s
            end
          end
        end
      end
    end
  end
end
