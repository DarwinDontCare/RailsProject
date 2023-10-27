module Organizer
    module Subscription
        class Delete
            include Interactor::Organizer
        
            organize Interactor::Subscription::Delete, Interactor::Subscription::SendEmail
        end
    end
end