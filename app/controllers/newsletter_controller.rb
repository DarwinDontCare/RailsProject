class NewsletterController < ApplicationController
  skip_before_action :verify_authenticity_token
    def create
        @modelo = Newsletter.new(modelo_params)

        result = Organizer::Newsletter::Validate.call(title: @modelo.title, model: Newsletter)

        puts result.success?
      
        if result.success? && @modelo.save
          render json: @modelo.to_json, status: :created
        else
          if result.message.blank?
            render json: {"message": @modelo.errors.full_messages}, status: :unauthorized
          else
            render json: {"message": result.message}, status: :unauthorized
          end 
        end
    end

    def destroy
      newsletter = Newsletter.find_by(id: params[:id])
      if newsletter && newsletter.destroy
        render json: newsletter.to_json, status: :ok
      else
        if newsletter
          render json: {"message": newsletter.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no newsletter with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def notifyReaders
      Workers::NotificationSender.perform_async(params[:id])
    end

    def show
      newsletter = Newsletter.find_by(id: params[:id])
      if newsletter
        render json: newsletter.to_json, status: :ok
      else
        if newsletter
          render json: {"message": newsletter.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no newsletter with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def update
      newsletter = Newsletter.find_by(id: params[:id])
      if newsletter && newsletter.update(modelo_params)
        render json: newsletter.to_json, status: :ok
      else
        if newsletter
          render json: {"message": newsletter.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no newsletter with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def index
        newsletter = Newsletter.all

        render json: newsletter, status: :ok
    end
      
    private
    
    def modelo_params
      params.require(:newsletter).permit(:active, :title, :content, :author_id, :book_id)
    end
end