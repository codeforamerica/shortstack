Rails.application.config.middleware.use OmniAuth::Builder do
  if ActiveRecord::Base.connection.tables.include?("settings")
    %w(twitter facebook github).each do |service|
      if setting = Setting.send("#{service}_key").first
        provider service.to_sym, setting.setting, Setting.send("#{service}_secret").first.setting
      end
    end
  end 
end