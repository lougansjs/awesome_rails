# frozen_string_literal: true

Discord::Notifier.setup do |config|
  config.url = 'https://discord.com/api/webhooks/910636095597871104/jNcXQtZPQMpbjyCHEED-puSpmxZlZdqa5XKJD8-ximjUBD0_U-vO8zM6hXgg0KqJqQoc'
  config.username = 'Capitão Aviso'
  config.avatar_url = 'https://i.ibb.co/MVV9cC9/as.png'

  # Defaults to `false`
  config.wait = true
end
