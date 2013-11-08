class Message < ActiveRecord::Base
  after_create :send_on_waitlist
  attr_accessible :phone_number
  belongs_to :reservation


  def send_on_waitlist
        @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
        # @message = @client.account.messages.create(
        #  body: "you have been added to the waitlist",
        # to: "+14152154051",
        # from: "+14159926163")
        puts "sending text message" 
  end
end