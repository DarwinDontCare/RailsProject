module Organizer
    module Newsletter
        class Validate
            include Interactor::Organizer
        
            organize Interactor::Newsletter::ValidateName
        end
    end
end