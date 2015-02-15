Redmine::Plugin.register :redmine_activiti do
  name 'Redmine Activiti plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  require 'redmine_activiti/hooks/success_authentication_after_hook'
end
