class Notifications < ActionMailer::Base
  default :from => "from@example.com"

  def contact(email_params, sent_at = Time.now)
    subject "Contact form submission"
    recipients "steven@tourioushq.com" #TODO: setup a contact email
    from email_params[:address]
    sent_on sent_at
    body :message => email_params[:body], :sender_name => email_params[:name], :sender_email => email_params[:email]
  end
end
