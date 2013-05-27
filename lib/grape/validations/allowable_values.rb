module Grape
	module Validations
		class AllowableValuesValidator < Grape::Validations::Validator

			def initialize(attrs, options, required, scope)
				@allowable_values = options
				super
			end

			def validate_param!(attr_name, params)
				if params[attr_name]
					if @allowable_values.is_a?(Array)
						unless @allowable_values.include? params[attr_name]
							raise Grape::Exceptions::Validation, :status => 400,
							      :param => @scope.full_name(attr_name), :message_key => :allowable_values
						end
					elsif @allowable_values.is_a?(Range)
						begin
							value = Integer(params[attr_name])
							unless @allowable_values.include? value
								raise Grape::Exceptions::Validation, :status => 400,
								      :param => @scope.full_name(attr_name), :message_key => :allowable_values
							end
						rescue Exception => e
							raise Grape::Exceptions::Validation, :status => 400,
							      :param => @scope.full_name(attr_name), :message_key => :allowable_values
						end
					end
				end
			end

		end
	end
end