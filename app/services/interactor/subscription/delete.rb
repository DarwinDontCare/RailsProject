module Interactor
    module Subscription
        class Delete
            include Interactor
        
            def call
                context.subscription = ::Subscription.find(context.subscription_id)
                if context.subscription.destroy
                    puts "successfuly deleted subscription!"
                    context.message = "successfuly deleted subscription!"
                else
                    puts "failed to deleted subscription"
                    context.message = "failed to deleted subscription"
                end
            end
        end
    end
end