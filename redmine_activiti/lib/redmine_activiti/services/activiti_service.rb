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
          'processDefinitionKey' => processDefinitionKey,
          'variables' => variables
        }.to_json

        response = self.class.post("/runtime/process-instances", @params)

        return if response.code == 201

        raise 'Start proccess Error'
      end

      protected

      def processDefinitionKey
        @processDefinitionKey ||= @issue.tracker.process_id
      end

      def processDefinition
        @processDefinition ||= self.class.get("/repository/process-definitions", @params.merge(query: {key: processDefinitionKey, latest: true}))["data"][0]
      end

      def variables
        @variables ||= self.class.get("/form/form-data", @params.merge(query: { processDefinitionId: processDefinition['id'] }))['formProperties'].map do |h|
          {
            'name' => h['id'],
            'value' => @issue.send(h['id'])
          }
        end
      end
    end
  end
end