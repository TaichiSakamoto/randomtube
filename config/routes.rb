Rails.application.routes.draw do
  get 'youtube/index' => 'youtube#index'
  get 'youtube/search' => 'youtube#search_movie'
  post 'youtube/search' => 'youtube#search_movie'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
