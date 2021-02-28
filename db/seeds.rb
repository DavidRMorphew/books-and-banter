
Review.destroy_all
Checkout.destroy_all
User.destroy_all
Book.destroy_all

User.create([
    {username:"LibraryAdmin", email:"bookmaster@library.com", password:"admin", admin: true}, 
    {username:"PhantomReader", email:"BillyZane@phantom.com", password:"pw"},
    {username: "Agamemnon-Lord-of-Books", email: "bookking@hey.com", password: "pw"}
    ])

Api.fetch_books("subject:fiction").each do |book|
    if book.valid?
        book.save
    end
end