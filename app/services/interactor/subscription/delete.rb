module Interactor
    module Subscription
        class Delete
            include Interactor
        
            def call
                context.subscription = ::Subscription.find_by(id: context.subscription_id)
                if context.subscription && context.subscription.destroy
                    puts "successfully deleted subscription!"
                    context.message = "successfully deleted subscription!"
                else
                    puts "failed to delete subscription"
                    context.message = "failed to delete subscription"
                end
            end
        end
    end
end