# PROJECT PLANNING

1) MODELS AND MIGRATIONS   

## Associations:
User
* has_many :checkouts, foreign_key: :borrower_id
* has_many :borrowed_books, through: :checkouts, source: :borrowed_book
* has_many :reviews, foreign_key: :reviewer_id
* has_many :reviewed_books, through: :reviews, source: :reviewed_book

Checkout
* belongs_to :borrower, class_name: "User"
* belongs_to :borrowed_book, class_name: "Book"

Review
* belongs_to :reviewer, class_name: "User"
* belongs_to :reviewed_book, class_name: "Book"

Book
* has_many :checkouts, foreign_key: :borrowed_book_id
* has_many :borrowers, through: :checkouts, source: :borrower
* has_many :reviews, foreign_key: :reviewed_book_id
* has_many :reviewers, through: :reviews, source: :reviewer

User Attributes:
* username
* email
* password (using has_secure_password Macro)
* admin:boolean, default: false

Book Attributes:
* author(s)
* isbn
* title
* description
* publisher
* publication_date:datetime
* categories

Checkout Attributes
* borrower_id
* borrowed_book_id
* checkout_date
* due_date

Review Attributes
* reviewer_id
* reviewed_book_id
* rating:integer
* title
* content:text
* recommend:boolean
* kid_friendly:boolean

2) Begin with User Model
- generate model and migration
- generate users_controller with new and show views 
- create actions in users_controller for new and create with routes get and post '/signup' in routes.rb
- create show action in users_controller

3) Logging In and Out
- generate sessions_controller
- create actions in sessions_controller for new and create with routes get and post '/login' 
- create action in sessions_controller for delete with route '/logout'

4.) Add Helper Methods and include in ApplicationController
- logged_in?
- current_user

5.) Build Models and Migrations
- Books
    - build controller and views
- Checkouts
    - build controller and views
- Reviews



NB
- add admin_authorization_check
- add authorized? check for user


