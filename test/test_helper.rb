require 'test/unit'
require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'

require File.dirname(__FILE__) + '/../init.rb'

Handler301::load_301_file(File.join(File.dirname(__FILE__), 'handler301_spec.yml'))

class Handler301Controller < ActionController::Base
  def show
    hash = request.query_parameters
    hash.delete(:path)
    return if handle_301(params[:path], hash)

    render :text => 'KO'
  end
end
