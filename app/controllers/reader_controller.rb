class ReaderController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    puts params
    @modelo = Reader.new(modelo_params)
  
    if @modelo.save
      render json: {"message": "successfuly created reader", "reader": @modelo.to_json}, status: :created
    else
      if @modelo
        render json: {"message": @modelo.errors.full_messages}, status: :unauthorized
      else
        render json: {"message": "failed to create reader"}, status: :unauthorized
      end 
    end
  end

  def destroy
    reader = Reader.find_by(id: params[:id])
    if reader && reader.destroy
      render json: reader.to_json, status: :ok
    else
      if reader
        render json: {"message": reader.errors.full_messages}, status: :unauthorized
      else 
        render json: {"message": "no reader with index #{params[:id]}"}, status: :not_found
      end
    end
  end

  def show
    reader = Reader.find_by(id: params[:id])
    if reader
      render json: reader.to_json, status: :ok
    else
      if reader
        render json: {"message": reader.errors.full_messages}, status: :unauthorized
      else 
        render json: {"message": "no reader with index #{params[:id]}"}, status: :not_found
      end
    end
  end

  def update
    reader = Reader.find_by(id: params[:id])
    if reader && reader.update(modelo_params)
      render json: reader.to_json, status: :ok
    else
      if reader
        render json: {"message": reader.errors.full_messages}, status: :unauthorized
      else 
        render json: {"message": "no reader with index #{params[:id]}"}, status: :not_found
      end
    end
  end

  def index
      readers = Reader.all

      render json: readers, status: :ok
  end

  def authenticate_reader
    reader = Reader.find_by(email: params[:email])
    if reader && reader.authenticate(params[:password])
      render json: {"message": "reader authenticated"}, status: :ok
    else
      if reader
        render json: {"message": reader.errors.full_messages}, status: :unauthorized
      else 
        render json: {"message": "no reader with index #{params[:id]}"}, status: :not_found
      end
    end
  end
    
  private
  
  def modelo_params
    params.permit(:nickname, :password, :email)
  end
end