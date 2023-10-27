class BookController < ApplicationController
  skip_before_action :verify_authenticity_token
    def create
        @modelo = Book.new(modelo_params)
      
        if @modelo.save
          Author.update(id: @modelo.author.id, books_id: @modelo.id)
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
      if book.destroy
        render json: book.to_json, status: :ok
      else
        render json: {"message": "error while trying to delete book"}, status: :unauthorized
      end
    end

    def show
      book = Book.find_by(id: params[:id])
      if book
        render json: book.to_json, status: :ok
      else
        render json: {"message": "unable to find book"}, status: :not_found
      end
    end

    def update
      book = Book.find_by(id: params[:id])
      if book.update(modelo_params)
        render json: book.to_json, status: :ok
      else
        render json: {"message": "error while trying to update book"}, status: :unauthorized
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
