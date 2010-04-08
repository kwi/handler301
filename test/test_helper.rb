require 'test/unit'
require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'

# Prepare 301 handler tests :
Handler301Table = YAML.load_file(File.join(File.dirname(__FILE__), 'handler301_spec.yml')) if !defined? Handler301Table

require File.dirname(__FILE__) + '/../init.rb'

class Handler301Controller < ActionController::Base
  def show
    return if handle_301(params[:path])

    render :text => 'KO'
  end
end
