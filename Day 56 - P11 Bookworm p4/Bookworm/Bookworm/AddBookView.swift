//
//  AddBookView.swift
//  Bookworm
//
//  Created by Loris on 13/03/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    var hasValidData: Bool {
        if title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty {
            return false
        }
        
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let book = Book(context: moc)
                        book.title = title
                        book.author = author
                        book.rating = Int16(rating)
                        book.genre = genre
                        book.review = review
                        book.date = Date()
                        book.formattedDate = makeFormattedDate(book.date ?? Date())
                        
                        try? moc.save()
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(hasValidData == false)
            }
            .navigationBarTitle(Text("Add Book"))
        }
    }
    
    func makeFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
