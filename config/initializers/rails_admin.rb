RailsAdmin.authenticate_with {
  authenticate_user!
}
RailsAdmin.authorize_with {
  authorize_user
}

RailsAdmin.config do |config|
  config.model User do
    edit do 
      group(:Authentications) do
        hide
      end
      group(:Contributions) do
        hide
      end
    end
  end
end
