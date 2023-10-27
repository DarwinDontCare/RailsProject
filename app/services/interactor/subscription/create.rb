module Interactor
    module Subscription
        class Create
            include Interactor
        
            def call
                context.subscription = ::Subscription.new(newsletter_id: context.newsletter_id, reader_id: context.reader_id)
                if context.subscription.save
                    puts "successfuly created subscription!"
                    context.message = "successfuly created subscription!"
                else
                    puts "failed to create subscription"
                    context.message = "failed to create subscription"
                end
            end
        end
    end
end