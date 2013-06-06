module MailJack
  class Interceptor
    def self.delivering_email(message)
      body = message.body.to_s
      hrefs = body.scan(/href=\"(.*?)\"/).flatten
      hrefs = hrefs.grep(MailJack.config.href_filter)
      hrefs = hrefs.uniq

      querystr = MailJack.trackables.keys.inject({}) {|hash, a| hash[a] = message.send(a); hash}.to_query
      hrefs.each do |h| 
        q = "?#{querystr}" unless h.include?("?")
        body.gsub!(h, "#{h}#{q}")
      end
      message.body = body
    end
  end
end