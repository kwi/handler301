Gem::Specification.new do |s|
  s.name = "handler301"
  s.version = "0.2.1"
  s.author = "Guillaume Luccisano"
  s.email = "guillaume.luccisano@gmail.com"
  s.homepage = "http://github.com/kwi/handler301"
  s.summary = "Simple rails 301 redirection handler with a config file. Rework your url schema without being worry !"
  s.description = "Handler 301 is a plugin for Ruby on Rails that lets you easily manage 301 redirections in on place in order to redirect them to current named routes. "

  s.files = Dir["{lib,spec}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end