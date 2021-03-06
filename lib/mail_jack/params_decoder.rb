module MailJack
  class ParamsDecoder
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) unless MailJack.configured?
      decode_params(env) if MailJack.config.enable_encoding?
      @status, @headers, @response = @app.call(env)
      [@status, @headers, @response]
    end   

    def decode_params(env)
      param_name = MailJack.config.encode_to
      return unless env['QUERY_STRING'].present? and env['QUERY_STRING'].match(/#{param_name}\=/)

      params = {'QUERY_STRING' => env["QUERY_STRING"], 'REQUEST_URI' => env["REQUEST_URI"].split("?")[1]}

      params.each do |key, value|
        next unless value.present?
        hash = Rack::Utils.parse_query(value)
        # next unless hash.has_key?(param_name.to_s)
        
        encoded = hash.delete(param_name.to_s)
        decoded = Base64.decode64(encoded) if encoded 

        env[key].gsub!("#{param_name}=#{encoded}", decoded) if decoded
      end
    end
  end
end