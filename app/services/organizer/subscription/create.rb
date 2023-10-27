module Organizer
    module Subscription
        class Create
            include Interactor::Organizer
        
            organize Interactor::Subscription::ValidateReader, Interactor::Subscription::Create, Interactor::Subscription::SendEmail
        end
    end
end