
![library image](https://i.imgur.com/tisbV2F.jpeg)
# Books & Banter

## Purpose and Usage

This app is intended to help create and persist an online catalogue of books for a library. It also builds out an online user interface for a library with checkout functionality, persisted checkout records, and shared thoughts on books through user submitted reviews.

As the admin, you first create a catalogue of book instances from Google Books with all of the usual data you would want on a book (such as title, authors, isbn, etc.). You can also use the google search feature to add more books to your library catalogue at any time, or you can add your own entries.

Once your catalogue is stocked, your users can sign up with google or manually to
* view, sort, and search the library (e.g. by author, title, description);
* create checkout records for books;
* and write and edit book reviews.

For ease of the admin's mind, there is an `appropriate language` custom validation for reviews, which you can use to disallow certain words or phrases. The disallowed word list currently includes phrases such as "gee willikers."

<p align="center">
  <img src="https://memegenerator.net/img/instances/75311436.jpg" alt="golly gee willickers, batman">
</p>

Go [here]() for a short video on how this app works.

## Installation
To install the program, open your Terminal and run the following command:

```
git clone git@github.com:DavidRMorphew/books-and-banter.git
```

## Starting the Program

Once installed, open the program's directory:
```
cd books-and-banter
```
Before starting, be sure to run 
```
bundle install
```

You will also want to create a `.env` file to store your `GOOGLE_BOOKS_API_KEY`.

This program uses the Google Books API to harvest book data on a given subject (currently set to "fiction") and the library admin's `ADD A NEW BOOK` feature uses the API to search for books on Google Books. Currently, you can run the api without a google books api key, but that accessibility is not assured for the future. If you want to try your luck without a key, delete `&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}` at the end of the `url` in l. 4 of app/models/api.rb:
```
4    url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&langRestrict=en&printType=books&maxResults=40&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
```

You can read more about how to use `dotenv` [here](https://github.com/bkeepers/dotenv) (Do not use quotation marks when assigning the value for the key!) and more on how this program interfaces with the Google Books API on my [blog](https://davidrmorphew.medium.com/google-books-api-search-filters-in-rails-how-i-learned-to-love-regex-and-send-4795c93f02ac).

## Run

To fill your library with books, create the admin user profile (and a couple of other user profiles), run the following command in your terminal:

```
rails db:seed
```

You can run the program locally on your computer by entering the following in your terminal:

```
rails s
```

This will bring up a localhost url that you can copy and paste into your browser to begin using the program, such as `localhost:3000`.

## Admin Account and Functions

The Library Admin profile is located in the `seeds.rb` file with: 
* `username`: "LibraryAdmin" 
* `email`: "bookmaster@library.com" 
* `password`: "admin"

You can use that information to access the admin account after seeding the app. 

Or, you can populate the `seeds.rb` file with your own admin account (just be sure to set the `admin` attribute to "true"), or create a new admin using the rails console.

## Contributing

Pull requests are welcome. If you want to make major changes, please open an issue first to discuss the proposed change.

Please feel free to add and update tests where appropriate.

This project is built for welcomed collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Future Functionality

The following are just a few areas open to future development:
- BUILD: search features for sorting, and filtering the library's checkouts records
- BUILD: more search features for viewing, sorting, and filtering the library's list of books
- BUILD: more many-to-many relations to persist authors, categories, and other shared book attributes as unique entries (see the current associations in the  `library_table.drawio` file, but you'll need a [draw.io extension](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio) or similar to view it when using VSCode)
- MODIFY: book search and create option for the admin to choose from several Google Books returned options



## License
The app open source under the terms of the [MIT License](https://github.com/DavidRMorphew/books-and-banter/blob/main/LICENSE.txt).