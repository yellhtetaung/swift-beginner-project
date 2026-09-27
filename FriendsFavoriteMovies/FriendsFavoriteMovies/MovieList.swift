//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Ye Htet Aung on 27/09/2026.
//

import SwiftData
import SwiftUI

struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?

    init(titleFilter: String = "") {
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }

        _movies = Query(filter: predicate, sort: \Movie.title)
    }

    var body: some View {
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(movie.title) {
                            MovieDetail(movie: movie)
                        }
                    }
                    .onDelete(perform: deleteMovie(indexes:))
                }
            } else {
                ContentUnavailableView("Add Movies", systemImage: "film.stack")
            }
        }
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem {
                Button("Add movie", systemImage: "plus", action: addMovie)
            }

            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }

    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }

    private func deleteMovie(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
}

#Preview {
    MovieList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Filtered") {
    MovieList(titleFilter: "tr")
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty List") {
    MovieList()
        .modelContainer(for: Movie.self, inMemory: true)
}
