//
//  ShowRowView.swift
//  Encore
//
//  Created by Ye Htet Aung on 21/09/2026.
//

import SwiftData
import SwiftUI

struct ShowRowView: View {
    let show: Show

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {
            Text(show.artistName)
                .font(.headline)

            HStack(spacing: 4) {
                Text(show.venueName)
                Text("-")
                Text(show.city)
            }
            .font(.headline)
            .foregroundStyle(.secondary)

            HStack {
                Text(show.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if let rating = show.rating {
                    Spacer()
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(
                                systemName: star <= rating
                                    ? "star.fill" : "star"
                            )
                            .foregroundStyle(
                                star <= rating ? Color.yellow : Color.secondary
                            )
                        }
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    ShowRowView(
        show: Show(
            artistName: "MGK",
            venueName: "Coke Areana",
            city: "New York",
            date: .now,
            status: .attended
        )
    )
}
