//
//  OnboardingView.swift
//  Encore
//
//  Created by Ye Htet Aung on 23/09/2026.
//

import SwiftUI
import UserNotifications

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    @State private var notificationRequested = false

    private let pages: [(icon: String, color: Color, title: String, description: String)] = [
        (
            "ticket.fill", .purple, "Your Concert History",
            "Log every show your're been to. Build a record of your live music journey."
        ),
        (
            "music.microphone.circle.fill", .pink, "Every Detail Captured",
            "Set lists, ratings, notes - everything that made each night unforgettable."
        ),
        ("calendar", .blue, "Never miss a show", "Save upcoming concerts and keep track of whats on your radar."),
    ]

    private var isLatestPage: Bool {
        currentPage == pages.count
    }

    private func advance() {
        if isLatestPage {
            hasCompletedOnboarding = true
        } else {
            withAnimation {
                currentPage += 1
            }
        }
    }

    var body: some View {

        VStack {
            TabView {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingPageView(
                        icon: pages[index].icon,
                        color: pages[index].color,
                        title: pages[index].title,
                        description: pages[index].description
                    )
                    .tag(index)
                }

                OnboardingNotificatonsPage(notificationRequested: $notificationRequested)
                    .tag(pages.count)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.easeInOut, value: currentPage)
            
            Button(action: advance) {
                Text(isLatestPage ? "Let's go" : "Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 32)
    }
}

#Preview {
    OnboardingView()
}
