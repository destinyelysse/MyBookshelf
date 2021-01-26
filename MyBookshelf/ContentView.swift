//
//  ContentView.swift
//  MyBookshelf
//
//  Created by Destiny Serna on 1/13/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext)  var moc

    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
    @State private var isShowingAddBookView = false

    var body: some View {
        
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)){
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("My Bookshelf")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.isShowingAddBookView.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingAddBookView) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find book in fetch request
            let book = books[offset]
            
            //delete it from the context
            moc.delete(book)
        }
        try? moc.save()
    }
}
        

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
