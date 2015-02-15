module RedmineActiviti
  module Services

    class ActivitiService
      include HTTParty
      base_uri 'http://localhost:8080/activiti-rest/service'

      def initialize(issue, username, password)
        @issue = issue

        auth = {:username => username, :password => password}
        @params = {
          :basic_auth => auth,
          :headers => { 'Content-Type' => 'application/json',
            'Accept' => 'application/json'}
        }
      end

      def start_process
        @params[:body] = {
          'processDefinitionKey' => @issue.tracker.process_id
        }.to_json

        pd = self.class.post("/runtime/process-instances", @params)
      end
    end

  end
end