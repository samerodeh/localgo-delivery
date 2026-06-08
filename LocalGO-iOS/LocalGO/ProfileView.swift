import SwiftUI

// MARK: - ProfileView
struct ProfileView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var darkModeEnabled: Bool = false
    @State private var showSignOutAlert: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.brandBackground.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Avatar Card
                        avatarCard
                            .padding(.horizontal, 20)
                            .padding(.top, 8)

                        // Stats Row
                        statsRow
                            .padding(.horizontal, 20)

                        // Account Section
                        ProfileSection(title: "Account") {
                            ProfileRow(icon: "mappin.and.ellipse", label: "Saved Addresses")
                            Divider().padding(.leading, 44)
                            ProfileRow(icon: "creditcard", label: "Payment Methods")
                            Divider().padding(.leading, 44)
                            ProfileRow(icon: "tag.fill", label: "Promotions")
                        }
                        .padding(.horizontal, 20)

                        // Preferences Section
                        ProfileSection(title: "Preferences") {
                            ProfileToggleRow(
                                icon: "bell.fill",
                                label: "Notifications",
                                isOn: $notificationsEnabled
                            )
                            Divider().padding(.leading, 44)
                            ProfileRow(icon: "globe", label: "Language", detail: "English")
                            Divider().padding(.leading, 44)
                            ProfileToggleRow(
                                icon: "moon.fill",
                                label: "Dark Mode",
                                isOn: $darkModeEnabled
                            )
                        }
                        .padding(.horizontal, 20)

                        // Support Section
                        ProfileSection(title: "Support") {
                            ProfileRow(icon: "questionmark.circle.fill", label: "Help Center")
                            Divider().padding(.leading, 44)
                            ProfileRow(icon: "message.fill", label: "Contact Support")
                            Divider().padding(.leading, 44)
                            ProfileRow(icon: "doc.text.fill", label: "Terms of Service")
                            Divider().padding(.leading, 44)
                            Button {
                                showSignOutAlert = true
                            } label: {
                                HStack(spacing: 14) {
                                    Image(systemName: "arrow.right.square.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.red)
                                        .frame(width: 30)
                                    Text("Sign Out")
                                        .font(.system(size: 15))
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                            }
                        }
                        .padding(.horizontal, 20)

                        // Footer version
                        Text("v1.0.0")
                            .font(.caption)
                            .foregroundColor(.brandMuted)
                            .padding(.bottom, 32)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .alert("Sign Out", isPresented: $showSignOutAlert) {
                Button("Sign Out", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }

    // MARK: Avatar Card
    private var avatarCard: some View {
        HStack(spacing: 16) {
            // Circle avatar
            ZStack {
                Circle()
                    .fill(Color.brandNavy)
                    .frame(width: 66, height: 66)
                Text("S")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("Samer Odeh")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.brandNavy)
                Text("samerodeh2006@gmail.com")
                    .font(.system(size: 12))
                    .foregroundColor(.brandTextSecondary)
            }

            Spacer()

            Button {
                // Edit profile action
            } label: {
                Text("Edit")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color.brandOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }

    // MARK: Stats Row
    private var statsRow: some View {
        HStack(spacing: 0) {
            StatCell(value: "24", label: "Orders")
            dividerLine
            StatCell(value: "6", label: "Saved")
            dividerLine
            StatCell(value: "11", label: "Reviews")
        }
        .padding(.vertical, 14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 1)
    }

    private var dividerLine: some View {
        Rectangle()
            .fill(Color.brandGray100)
            .frame(width: 1, height: 40)
    }
}

// MARK: - StatCell
struct StatCell: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.brandNavy)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.brandTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - ProfileSection
struct ProfileSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.brandMuted)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 1)
        }
    }
}

// MARK: - ProfileRow
struct ProfileRow: View {
    let icon: String
    let label: String
    var detail: String? = nil

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundColor(.brandNavy)
                .frame(width: 30)

            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.brandNavy)

            Spacer()

            if let detail {
                Text(detail)
                    .font(.system(size: 13))
                    .foregroundColor(.brandMuted)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.brandMuted)
        }
        .padding(.vertical, 12)
    }
}

// MARK: - ProfileToggleRow
struct ProfileToggleRow: View {
    let icon: String
    let label: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundColor(.brandNavy)
                .frame(width: 30)

            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.brandNavy)

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.brandOrange)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ProfileView()
}
