class AuthorController < ApplicationController
  skip_before_action :verify_authenticity_token
    def create
        @modelo = Author.new(modelo_params)
      
        if @modelo.save
          render json: {"message": "successfuly created author", "author": @modelo.to_json}, status: :created
        else
          if result.message.blank?
            render json: {"message": @modelo.errors.full_messages}, status: :unauthorized
          else
            if result.message.blank?
              render json: {"message": @modelo.errors.full_messages}, status: :unauthorized
            else
              render json: {"message": result.message}, status: :unauthorized
            end 
          end 
        end
    end

    def delete_related_object(object, author)
      object.all.each do |eq|
        if eq.author_id == author.id
          eq.destroy
        end
      end
    end

    def destroy
      author = Author.find_by(id: params[:id])

      if author && author.destroy
        render json: author.to_json, status: :ok
      else
        if author
          render json: {"message": author.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no author with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def show
      author = Author.find_by(id: params[:id])
      if author
        render json: author.to_json, status: :ok
      else
        if author
          render json: {"message": author.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no author with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def update
      author = Author.find_by(id: params[:id])
      if author && author.update(modelo_params)
        render json: author.to_json, status: :ok
      else
        if author
          render json: {"message": author.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no author with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def index
        authors = Author.all

        render json: authors, status: :ok
    end
      
    private
    
    def modelo_params
      params.permit(:name, :birth_date, :email)
    end
end
