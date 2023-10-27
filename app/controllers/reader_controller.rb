class ReaderController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    puts params
    @modelo = Reader.new(modelo_params)
  
    if @modelo.save
      render json: {"message": "successfuly created reader", "reader": @modelo.to_json}, status: :created
    else
      if result.message.blank?
        render json: {"message": @modelo.errors.full_messages}, status: :unauthorized
      else
        render json: {"message": result.message}, status: :unauthorized
      end 
    end
  end

  def destroy
    reader = Reader.find_by(id: params[:id])
    if reader.destroy
      render json: reader.to_json, status: :ok
    else
      render json: {"message": "error while trying to delete reader"}, status: :unauthorized
    end
  end

  def show
    reader = Reader.find_by(id: params[:id])
    if reader
      render json: reader.to_json, status: :ok
    else
      render json: {"message": "unable to find reader"}, status: :not_found
    end
  end

  def update
    reader = Reader.find_by(id: params[:id])
    if reader.update(modelo_params)
      render json: reader.to_json, status: :ok
    else
      render json: {"message": "error while trying to update reader"}, status: :unauthorized
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
      render json: {"message": "wrong reader credentials"}, status: :unauthorized
    end
  end
    
  private
  
  def modelo_params
    params.permit(:nickname, :password, :email)
  end
end