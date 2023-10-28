module Interactor
    module Subscription
        class Create
            include Interactor
        
            def call
                context.reader = ::Reader.find_by(id: context.reader_id)
                context.newsletter = ::Newsletter.find_by(id: context.newsletter_id)
                context.subscription = ::Subscription.new(newsletter: context.newsletter, reader: context.reader)
                if !context.reader
                    context.fail!(message: "could not find reader with index #{context.reader_id}")
                end

                if !context.newsletter
                    context.fail!(message: "could not find newsletter with index #{context.newsletter_id}")
                end
                context.author_id = context.newsletter.author_id

                context.email_content = "#{context.reader.email} subscribed to #{context.newsletter.title}"

                if context.subscription && context.subscription.save
                    puts "successfully created subscription!"
                    context.message = "successfully created subscription!"
                else
                    puts "failed to create subscription"
                    context.message = "failed to create subscription"
                end
            end
        end
    end
end