class BookController < ApplicationController
  skip_before_action :verify_authenticity_token
    def create
        @modelo = Book.new(modelo_params)
      
        if @modelo.save
          render json: {"message": "successfuly created book", "book": @modelo.to_json}, status: :created
        else
          if result.message.blank?
            render json: {"message": @modelo.errors.full_messages}, status: :unauthorized
          else
            render json: {"message": result.message}, status: :unauthorized
          end 
        end
    end

    def destroy
      book = Book.find_by(id: params[:id])
      if book && book.destroy
        render json: book.to_json, status: :ok
      else
        if book
          render json: {"message": book.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no book with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def show
      book = Book.find_by(id: params[:id])
      if book
        render json: book.to_json, status: :ok
      else
        if book
          render json: {"message": book.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no book with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def update
      book = Book.find_by(id: params[:id])
      if book && book.update(modelo_params)
        render json: book.to_json, status: :ok
      else
        if book
          render json: {"message": book.errors.full_messages}, status: :unauthorized
        else 
          render json: {"message": "no book with index #{params[:id]}"}, status: :not_found
        end
      end
    end

    def index
        books = Book.all

        render json: books, status: :ok
    end
    
    private
    
    def modelo_params
      params.permit(:name, :author_id)
    end
end
