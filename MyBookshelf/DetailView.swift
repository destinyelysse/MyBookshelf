//
//  DetailView.swift
//  MyBookshelf
//
//  Created by Destiny Serna on 1/15/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No Review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        
        let book = Book(context: moc)
        book.title = "A Book Title"
        book.author = "Book Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "What a great read!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
