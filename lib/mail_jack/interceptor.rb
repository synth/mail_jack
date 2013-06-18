module MailJack
  class Interceptor
    def self.delivering_email(message)
      querystr = generate_query_string(message)

      if message.multipart?
        message.parts.each do |part|
          unless part.attachment?
            part.body = append_links(part.body, querystr)
          end
        end
      else
        message.body = append_links(message.body, querystr)
      end
    end

    def self.generate_query_string(message)
      querystr = MailJack.trackables.keys.inject({}) {|hash, a| hash[a] = message.send(a); hash}.to_query
      if MailJack.config.enable_encoding?
        querystr = "#{MailJack.config.encode_to}=#{Base64.encode64(querystr)}"
      end
      return querystr
    end

    def self.append_links(text, querystr)
      str = text.to_s
      hrefs = str.scan(/href=\"(.*?)\"/).flatten
      hrefs = hrefs.grep(MailJack.config.href_filter)
      hrefs = hrefs.uniq

      hrefs.each do |h| 
        q = h.include?("?") ?  "&#{querystr}" : "?#{querystr}" 
        str.gsub!(h, "#{h}#{q}")
      end
      return str
    end
  end
end