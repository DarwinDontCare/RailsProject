module Interactor
    module Newsletter
        class ValidateName
            include Interactor
        
            def call
                if ::Newsletter.count > 0 && ::Newsletter.exists?(title: context.title)
                    context.fail!(message: "a newsletter with this name already exists")
                end
            end
        end
    end
end