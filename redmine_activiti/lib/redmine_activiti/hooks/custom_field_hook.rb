module RedmineActiviti
  module Hooks
    class CustomFieldHook < Redmine::Hook::ViewListener
      def view_custom_fields_form_issue_custom_field(params)
        "<p>#{params[:form].text_field :method_name}</p>"
      end
    end
  end
end