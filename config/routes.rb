Rails.application.routes.draw do
  resources :subjects do
    resources :course_groups do
      member do
        post 'registrate'
        post 'deregistrate'
        post 'update_grades'
      end
    end
  end
  get 'course_groups/overview' => 'course_groups#overview'

  resources :field_of_studies do
    resources :semesters do
      post 'add_students', on: :member
      delete 'remove_students', on: :member
    end
  end
  resources :registrations

  # modals
  get 'select_users' => 'modals#select_users', as: :select_users_modal
  get 'update_grades' => 'modals#update_grades', as: :update_grades_modal
  get 'add_students' => 'modals#add_students', as: :add_students_modal

  root 'dashboard#index'
  get 'my_study' => 'users#my_study', as: :my_study_user

  devise_for :users, skip: [:registrations]

  get 'language' => 'languages#change', as: :change_language

  resources :users do
    patch 'update_password', on: :member
  end

  get 'edit_account' => 'users#edit_account'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
