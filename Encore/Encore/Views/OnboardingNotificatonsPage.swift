//
//  OnboardingNotificatonsPage.swift
//  Encore
//
//  Created by Ye Htet Aung on 23/09/2026.
//

import SwiftUI
import UserNotifications

struct OnboardingNotificatonsPage: View {
    @Binding var notificationRequested: Bool
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "bell.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(.orange)
            Text("Show Remainders")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("Get notified before upcoming shows so you're always ready!")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            if notificationRequested {
                Label("You're all set!", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .font(.headline)
            } else {
                Button("Enable Notifications") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                        granted,
                        _ in
                        DispatchQueue.main.async {
                            notificationRequested = true
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardingNotificatonsPage(notificationRequested: .constant(false))
}
