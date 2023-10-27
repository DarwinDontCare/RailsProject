class SubscriptionController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
      subscriptions = Subscription.all

      render json: subscriptions, status: :ok
  end

  def show
    subscription = Subscription.find_by(id: params[:id])
    if subscription
      render json: subscription.to_json, status: :ok
    else
      render json: {"message": "unable to find subscription"}, status: :not_found
    end
  end

  def update
    subscription = Subscription.find_by(id: params[:id])
    if subscription.update(modelo_params)
      render json: subscription.to_json, status: :ok
    else
      render json: {"message": "error while trying to update subscription"}, status: :unauthorized
    end
  end

  def subscribe
    email_content = "#{Reader.find_by(id: params["reader_id"]).email} subscribed to #{Newsletter.find_by(id: params["newsletter_id"]).title}"
    result = Organizer::Subscription::Create.call(newsletter_id: params["newsletter_id"], reader_id: params["reader_id"], email_content: email_content, author_id: Newsletter.find_by(id: params["newsletter_id"]).author_id)
    
    if result.success?
      render json: result.subscription.to_json, status: :ok
    else
      render json: {"message": result.message}, status: :unauthorized
    end
  end

  def unsubscribe
    subscription = Subscription.find_by(id: params["subscription_id"])
    author_id = Newsletter.find_by(id: subscription.newsletter_id).author_id
    email_content = "#{Reader.find_by(id: subscription.reader_id).email} unsubscribed to #{Newsletter.find_by(id: subscription.newsletter_id).title}"
    result = Organizer::Subscription::Delete.call(subscription_id: params["subscription_id"], email_content: email_content, author_id: author_id)
    
    if result.success?
      render json: {"message": "successfuly deleted subscription"}, status: :ok
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
    
  private
  
  def modelo_params
      params.permit(:reader_id, :newsletter_id, :active, subscription_id:)
  end
end