# encoding: utf-8

# Stock 301 urls table
Handler301Table = (YAML.load_file(Rails.root.join('/config/handler301.yml')) rescue {}) if !defined? Handler301Table

require File.join(File.dirname(__FILE__), 'lib', 'handler301')

# Include 301 handler in ActionController base
ActionController::Base.send :include, Handler301