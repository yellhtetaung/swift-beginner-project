//
//  StarRating.swift
//  Encore
//
//  Created by Ye Htet Aung on 23/09/2026.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    private let maxRating = 5

    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Button {
                    withAnimation(.spring(response: 0.5)) {
                        rating = rating == star ? 0 : star
                    }
                } label: {
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundStyle(star <= rating ? .yellow : .secondary)
                        .scaleEffect(star <= rating ? 1.1 : 1.0)
                        .animation(.spring(response: 0.5), value: rating)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    StarRatingView(rating: .constant(4))
}
