ActionMailer::Base.smtp_settings = {
  :address              => "smtp.locum.ru",
  :port                 => 25,
  :domain               => "turs.pro",
  :user_name            => "support@turs.pro",
  :password             => "gjhnfknehcghj",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?