# encoding: utf-8

require File.join(File.dirname(__FILE__), 'lib', 'handler301')

# Load config 301 file
if defined? Rails
  Handler301::load_301_file(Rails.root.join('config/handler301.yml'))
end

# Include 301 handler in ActionController base
ActionController::Base.send :include, Handler301