Rails.application.routes.draw do
  # resources :short_urls, :only => [:show]
  get '/k/:id' => 'short_urls#show'
end
