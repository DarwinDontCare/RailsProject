module Interactor 
    module Subscription
        class ValidateReader
            include Interactor
        
            def call
                context.newsletter = ::Newsletter.find(context.newsletter_id)
                if ::Subscription.exists?(reader_id: context.reader_id, newsletter_id: context.newsletter_id)
                    context.fail!(message: "this reader already have a subscription to #{context.newsletter.title}")
                end
            end
        end
    end
end