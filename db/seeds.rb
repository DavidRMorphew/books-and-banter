# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Book.destroy_all
Review.destroy_all
Checkout.destroy_all

User.create([
    {username:"LibraryAdmin", email:"bookmaster@library.com", password:"admin", admin: true}, 
    {username:"PhantomReader", email:"BillyZane@phantom.com", password:"pw"},
    {username: "Agamemnon-Lord-of-Books", email: "bookking@hey.com", password: "pw"}
    ])

Book.books_instances_array_from_api("subject:fiction&maxResults=40").each do |book|
    if book.valid?
        book.save
    end
end
# Book.create({
#     authors: "George Herbert",
#     isbn: "ISBN 10: 0441013597, ISBN 13: 9780441013593", 
#     title: "Dune", 
#     description: "Follows the adventures of Paul Atreides, the son of a betrayed duke given up for dead on a treacherous desert planet and adopted by its fierce, nomadic people, who help him unravel his most unexpected destiny", 
#     publisher: "Penguin", 
#     publication_date: "2005", 
#     categories: "Fiction"
#     })
# Book.create({
#     authors: "Isaac Asimov", 
#     isbn: "ISBN 13: 9780307593962, ISBN 10: 0307593967", 
#     title: "Foundation: Foundation and Empire ; Second Foundation", 
#     description: "The Foundation, established after the Old Empire gives way to barbarism, fights against a mutant strain called the Mule and tries to get rid of the Second Foundation after learning it will inherit a future Empire.", 
#     publisher: "Everyman's Library", 
#     publication_date: "2010", 
#     categories: "Fiction"
#     })
# Book.create({
#         authors: "Brian Herbert, Kevin J. Anderson, Mystery Author Three", 
#         isbn: "ISBN 13: 9781429955904, ISBN 10: 1429955902", 
#         title: "Dune: The Butlerian Jihad: Book One of the Legends of Dune Trilogy", 
#         description: "Frank Herbert's Dune series is one of the grandest epics in the annals of imaginative literature. Selling millions of copies worldwide, it is science fiction's answer to The Lord of the Rings, a brilliantly imaginative epic of high adventure, unforgettable characters, and immense scope. Decades after Herbert's original novels, the Dune saga was continued by Frank Herbert's son, Brian Herbert, an acclaimed SF novelist in his own right, in collaboration with Kevin J. Anderson. Their New York Times bestselling trilogy, Dune: House Atreides, Dune: House Harkonnen, and Dune: House Corrino, formed a prequel to the classic Herbert series that was acclaimed by reviewers and readers alike. Now Herbert and Anderson, working from Frank Herbert's own notes, reveal a pivotal epoch in the history of the Dune universe, the chapter of the saga most eagerly anticipated by readers: The Butlerian Jihad. Throughout the Dune novels, Frank Herbert frequently referred to the long-ago war in which humans wrested their freedom from \"thinking machines.\" Now, in Dune: Butlerian Jihad, Brian Herbert and Kevin J. Anderson bring to life the story of that war, a tale previously seen only in tantalizing hints and clues. Finally, we see how Serena Butler's passionate grief ignites the war that will liberate humans from their machine masters. We learn the circumstances of the betrayal that made mortal enemies of House Atreides and House Harkonnen; and we experience the Battle of Corrin that created a galactic empire that lasted until the reign of Emperor Shaddam IV. Herein are the foundations of the Bene Gesserit Sisterhood, the Suk Doctors, the Order of Mentats, and the mysteriously altered Navigators of the Spacing Guild. Here is the amazing tale of the Zensunni Wanderers, who escape bondage to flee to the desert world where they will declare themselves the Free Men of Dune. And here is the backward, nearly forgotten planet of Arrakis, where traders have discovered the remarkable properties of the spice melange . . . . Ten thousand years before the events of Dune, humans have managed to battle the remorseless Machines to a standstill . . . but victory may be short-lived. Yet amid shortsighted squabbling between nobles, new leaders have begun to emerge. Among them are Xavier Harkonnen, military leader of the Planet of Salusa Secundus; Xavier's fiancée, Serena Butler, an activist who will become the unwilling leader of millions; and Tio Holtzman, the scientist struggling to devise a weapon that will help the human cause. Against the brute efficiency of their adversaries, these leaders and the human race have only imagination, compassion, and the capacity for love. It will have to be enough. At the Publisher's request, this title is being sold without Digital Rights Management Software (DRM) applied.", 
#         publisher: "Macmillan", 
#         publication_date: "2010", 
#         categories: "Fiction"
# })

