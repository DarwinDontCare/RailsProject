module Organizer
    module Newsletter
        class NotifyReaders
            include Interactor::Organizer
        
            organize Interactor::Newsletter::SendNotificationToReaders
        end
    end
end