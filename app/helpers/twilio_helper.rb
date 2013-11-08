module TwilioHelper

  def self.send_on_waitlist(phone_number,message)
        @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
        # @message = @client.account.messages.create(
        #  body: message,
        # to: phone_number,
        # from: "+14159926163")
        puts "sending text message" 
  end

end