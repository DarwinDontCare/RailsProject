class ServerMailer < ApplicationMailer
    default from: 'rails_server@companie.com'

    def send_email
      mail(to: params[:email], subject: params[:message])
    end
end
