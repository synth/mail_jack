class Railtie < Rails::Railtie
  initializer "mail_jack.configure_rails_initialization" do |app|
    app.middleware.use MailJack::ParamsDecoder
  end
end