//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Ye Htet Aung on 27/09/2026.
//

import SwiftData
import SwiftUI

struct FriendDetail: View {
    @Bindable var friend: Friend
    let isNew: Bool

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Movie.title) private var movies: [Movie]

    init(friend: Friend, isNew: Bool = false) {
        self.friend = friend
        self.isNew = isNew
    }

    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()

            Picker("Favorite Movie", selection: $friend.favoriteMovie) {
                Text("None")
                    .tag(nil as Movie?)

                ForEach(movies) { movie in
                    Text(movie.title)
                        .tag(movie)
                }
            }
        }
        .navigationTitle(isNew ? "New Friend" : "Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(friend)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Friend") {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
