module Interactor 
    module Subscription
        class SendEmail
            include Interactor
        
            def call
                context.author = Author.find(context.author_id)
                puts "sending email to #{context.author.name}, content: #{context.email_content}"
                ServerMailer.with(email: context.author.email, message: context.email_content).send_email.deliver_later
            end
        end
    end
end