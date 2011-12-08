class Admin::BaseController < ApplicationController
  layout "admin"
  before_filter :admin_required

  class << self
    def batch_action(model, actions, &block)
      define_method :batch_action do
        ids = params[:ids] || []
        unless ids.empty?
          users = model.find(ids)
          action = actions.find { |k, v| params.keys.include?(k.to_s) }
          if action.is_a?(Array)
            action = action.last
            users.each(&action)
          end
        end
        instance_exec(&block) if block_given?
        redirect_to :action => :index
      end
    end
  end
end
