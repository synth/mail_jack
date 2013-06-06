module MailJack
  class Config
    attr_accessor :mailers, :href_filter, :trackables, :encode_to
    def trackable

      # use OpenStruct for sugary assignment
      @trackables = OpenStruct.new
      yield @trackables

      #convert from a struct to a map
      @trackables = @trackables.methods(false).map(&:to_s).reject{|m| m.match(/\=$/) }.inject({}) {|hash, m| hash[m.to_sym] = @trackables.send(m); hash}
    end

    def enable_encoding?
      self.encode_to.present?
    end

  end
end