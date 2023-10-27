class NewsletterController < ApplicationController
  skip_before_action :verify_authenticity_token
    def create
        @modelo = Newsletter.new(modelo_params)

        result = Organizer::Newsletter::Validate.call(title: @modelo.title, model: Newsletter)

        puts result.success?
      
        if result.success? && @modelo.save
            Author.update(id: @modelo.author.id, newsletters_id: @modelo.id)
          render json: result.to_json, status: :created
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
      if newsletter.destroy
        render json: newsletter.to_json, status: :ok
      else
        render json: {"message": "error while trying to delete newsletter"}, status: :unauthorized
      end
    end

    def show
      newsletter = Newsletter.find_by(id: params[:id])
      if newsletter
        render json: newsletter.to_json, status: :ok
      else
        render json: {"message": "unable to find newsletter"}, status: :not_found
      end
    end

    def update
      newsletter = Newsletter.find_by(id: params[:id])
      if newsletter.update(modelo_params)
        render json: newsletter.to_json, status: :ok
      else
        render json: {"message": "error while trying to update newsletter"}, status: :unauthorized
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