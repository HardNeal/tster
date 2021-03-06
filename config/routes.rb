Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  resources :chats
  resources :common_chat_messages, only: [:create]
  get 'freekassa/new' => 'freekassa#new', as: :freekassa_new
  post 'freekassa/create' => 'freekassa#create', as: :freekassa_create
  get 'freekassa/confirm/:id' => 'freekassa#confirm', as: :freekassa_confirm
  post 'freekassa/result' => 'freekassa#result', as: :freekassa_result
  get 'freekassa/fail' => 'freekassa#fail', as: :freekassa_fail
  get 'freekassa/index' => 'freekassa#index', as: :freekassa_index

  resources :messages
  resources :chat_rooms
  get 'prepend_personal_message' => 'chat_rooms#prepend_personal_message', as: :prepend_personal_message
  ActiveAdmin.routes(self)
  resources :devnews, :homepages, :profiles, :avatars, :improves, :orders, :getmoneys, :getbalances, :feedbacks, :payeers

  #scope ":locale", locale: /en|ru/ do
    post 'buyall/:id' => 'improves#buyall', as: 'buyall'

    put 'buyallproviant/:id' => 'profiles#buyallproviant', as: 'buyallproviant'

    post 'buynumb/:id' => 'profiles#buynumb', as: 'buynumb'
    post 'imroveses/:id' => 'improves#imroveses', as: 'imroveses'


    put 'buyaerodrome/:id' => 'improves#buyaerodrome', as: 'buyaerodrome'
    put 'buyradist/:id' => 'improves#buyradist', as: 'buyradist'
    put 'getbonus/:id' => 'profiles#getbonus', as: 'getbonus'

    get 'service' => 'homepages#service', as: 'service'
    get 'contact' => 'homepages#contact', as: 'contact'
    get 'faq' => 'profiles#faq', as: 'faq'


    get 'mobline' => 'profiles#mobline', as: 'mobline'
    get 'partner' => 'profiles#partner', as: 'partner'

    root 'homepages#index'
  #end

    match '/success' => 'orders#success', via: :get
    match '/fail' => 'orders#fail', via: :get
    match 'payeer/success' => 'payeers#success', via: :get
    match 'payeer/fail' => 'payeers#fail', via: :get

  get '*path', to: redirect("/#{I18n.default_locale}")

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
  
end