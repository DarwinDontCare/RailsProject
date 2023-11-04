class NotificationSender
    include Sidekiq::Worker
  
    def perform(newsletter_id)
        result = Organizer::Newsletter::NotifyReaders.call(newsletter_id: newsletter_id)
        if result.success? && @modelo.save
            render json: {"message": "successfully sent notification"}, status: :created
          else
            if result.message.blank?
              render json: {"message": result.error}, status: :unauthorized
            else
              render json: {"message": result.message}, status: :unauthorized
            end 
          end
    end
end