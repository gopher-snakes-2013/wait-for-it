module TwilioHelper

  def self.send_on_waitlist(phone_number, message)
        @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
  #       @message = @client.account.messages.create(
  #         body: message,
  #         to: phone_number,
  #         from: "+14159926163")
  end

  def self.table_ready(phone_number, retaurant_name)
       @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
        # @message = @client.account.messages.create(
        #   body: "Your table at #{restaurant_name} is now ready!",
        #   to: phone_number,
        #   from: "+14159926163")
  end

end