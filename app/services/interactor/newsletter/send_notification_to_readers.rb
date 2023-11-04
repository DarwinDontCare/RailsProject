module Interactor
    module Newsletter
        class SendNotificationToReaders
            include Interactor
        
            def call
                context.newsletter = ::Newsletter.find_by(id: context.newsletter_id)
                context.subscriptions = context.newsletter.subscriptions

                context.subscriptions.each do |subscription|
                    puts "sending notification to #{subscription.reader.name}"
                end
            end
        end
    end
end