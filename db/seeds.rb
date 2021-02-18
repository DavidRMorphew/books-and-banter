# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.create({
    authors: "George Herbert",
    isbn: "ISBN 10: 0441013597, ISBN 13: 9780441013593", 
    title: "Dune", 
    description: "Follows the adventures of Paul Atreides, the son of a betrayed duke given up for dead on a treacherous desert planet and adopted by its fierce, nomadic people, who help him unravel his most unexpected destiny", 
    publisher: "Penguin", 
    publication_date: "2005", 
    categories: "Fiction"
    })
Book.create({
    authors: "Isaac Asimov", 
    isbn: "ISBN 13: 9780307593962, ISBN 10: 0307593967", 
    title: "Foundation: Foundation and Empire ; Second Foundation", 
    description: "The Foundation, established after the Old Empire gives way to barbarism, fights against a mutant strain called the Mule and tries to get rid of the Second Foundation after learning it will inherit a future Empire.", 
    publisher: "Everyman's Library", 
    publication_date: "2010", 
    categories: "Fiction"
    })
