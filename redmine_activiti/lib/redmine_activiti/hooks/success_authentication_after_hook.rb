module RedmineActiviti
  module Hooks
    class SuccessAuthenticationAfterHook < Redmine::Hook::ViewListener

      # TODO - THIS IS NOT A GOOD IDEA
      def controller_account_success_authentication_after(context={ })
        controller = context[:controller]
        params = controller.params
        controller.session[:password] = params[:password]
      end
    end
  end
end