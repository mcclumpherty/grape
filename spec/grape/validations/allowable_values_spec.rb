require 'spec_helper'

describe Grape::Validations::AllowableValuesValidator do

	module ValidationsSpec
		module AllowableValuesValidatorSpec
			class API < Grape::API
				default_format :json

				params do
					requires :letter, :allowable_values => ['a', 'b', 'c']
				end
				get '/list' do
				end

				params do
					requires :number, :allowable_values => 50..100
				end
				get '/range' do
				end
			end
		end
	end

	def app
		ValidationsSpec::AllowableValuesValidatorSpec::API
	end

	it 'refuses invalid list input' do
		get '/list', :letter => "d"
		last_response.status.should == 400
	end

	it 'accepts valid list input' do
		get '/list', :letter => "c"
		last_response.status.should == 200
	end

	it 'refuses invalid type range input' do
		get '/list', :number => "c"
		last_response.status.should == 400
	end

	it 'refuses invalid range value input' do
		get '/range', :number => "49"
		last_response.status.should == 400
	end

	it 'accepts valid range input' do
		get '/range', :number => "50"
		last_response.status.should == 200
	end

end
