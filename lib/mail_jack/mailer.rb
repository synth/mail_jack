module MailJack
    module Mailer
    def self.included(base)
      base.class_eval do
        alias_method_chain :mail, :tracking
      end
    end

    def mail_with_tracking(*args, &block)
      message = mail_without_tracking(*args, &block)

      # get a map of the required attributes
      attributes = MailJack.fetch_attributes(self)
      
      # assign them to the mail message
      attributes.each do |key, val|
        message.send("#{key}=", val)
      end
      return message
    end
  end
end
