module RedmineActiviti
  module Hooks
    class ControllerIssuesNewAfterSaveHook < Redmine::Hook::ViewListener
      def controller_issues_new_after_save(context={ })
        issue   = context[:issue]
        tracker = issue.tracker

        return if tracker.process_id.blank?

        controller = context[:controller]
        user = User.current
        start_process(issue, user.login, controller.session['password'])
      end

      private

      def start_process(issue, user, password)
        activiti_service = RedmineActiviti::Services::ActivitiService.new(issue, user, password)
        activiti_service.start_process
      end
    end
  end
end