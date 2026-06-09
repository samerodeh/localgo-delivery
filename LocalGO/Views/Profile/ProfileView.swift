import SwiftUI

struct ProfileView: View {

    struct MenuItem {
        let icon: String
        let label: String
        var sub: String? = nil
        var isDanger: Bool = false
    }

    let sections: [(title: String, items: [MenuItem])] = [
        ("Account", [
            MenuItem(icon: "location.on.rectangle", label: "Saved Addresses", sub: "2 addresses"),
            MenuItem(icon: "creditcard",             label: "Payment Methods",  sub: "Visa ····4242"),
            MenuItem(icon: "gift",                   label: "Promotions & Coupons"),
        ]),
        ("Preferences", [
            MenuItem(icon: "bell",        label: "Notifications"),
            MenuItem(icon: "globe",       label: "Language",  sub: "English"),
            MenuItem(icon: "moon.stars",  label: "Dark Mode"),
        ]),
        ("Support", [
            MenuItem(icon: "questionmark.circle", label: "Help Center"),
            MenuItem(icon: "bubble.left",         label: "Contact Support"),
            MenuItem(icon: "doc.text",            label: "Terms & Privacy"),
            MenuItem(icon: "rectangle.portrait.and.arrow.right", label: "Sign Out", isDanger: true),
        ]),
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color.navyDeep
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Text("Profile")
                        .font(.system(size: 22, weight: .black))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        avatarCard
                            .padding(.horizontal, 20)
                            .padding(.top, 24)
                            .padding(.bottom, 14)

                        statsRow
                            .padding(.horizontal, 20)
                            .padding(.bottom, 24)

                        ForEach(sections, id: \.title) { sec in
                            sectionBlock(title: sec.title, items: sec.items)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                        }

                        Text("LocalGO v1.0.0")
                            .font(.system(size: 12))
                            .foregroundColor(Color.muted)
                            .padding(.bottom, 30)
                    }
                }
                .background(Color.appBackground)
                .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
            }
        }
        .background(Color.navyDeep.ignoresSafeArea())
    }

    // MARK: - Avatar card
    private var avatarCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.navyDeep)
                    .frame(width: 54, height: 54)
                Text("S")
                    .font(.system(size: 22, weight: .black))
                    .foregroundColor(Color.brand)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("Samer Odeh")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color.textPrimary)
                Text("samerodeh.dev@gmail.com")
                    .font(.system(size: 12))
                    .foregroundColor(Color.textSecondary)
            }
            Spacer()
            Button {} label: {
                Image(systemName: "pencil")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.brand)
                    .frame(width: 36, height: 36)
                    .background(Color.brand.opacity(0.12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.brand, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .cardShadow()
    }

    // MARK: - Stats
    private var statsRow: some View {
        HStack(spacing: 0) {
            ForEach([("24", "Orders"), ("6", "Saved"), ("11", "Reviews")], id: \.0) { val, lbl in
                VStack(spacing: 2) {
                    Text(val)
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(Color.brand)
                    Text(lbl)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color.muted)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }
        }
        .background(Color.navyDeep)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Settings section
    private func sectionBlock(title: String, items: [MenuItem]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color.muted)
                .tracking(0.8)
                .textCase(.uppercase)
                .padding(.leading, 4)

            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.label) { i, item in
                    menuRow(item: item)
                    if i < items.count - 1 {
                        Divider().padding(.leading, 56)
                    }
                }
            }
            .background(Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .subtleShadow()
        }
    }

    private func menuRow(_ item: MenuItem) -> some View {
        Button {} label: {
            HStack(spacing: 12) {
                Image(systemName: item.icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(item.isDanger ? Color.appError : Color.navy)
                    .frame(width: 36, height: 36)
                    .background(item.isDanger ? Color.appError.opacity(0.1) : Color.gray100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 1) {
                    Text(item.label)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(item.isDanger ? Color.appError : Color.textPrimary)
                    if let sub = item.sub {
                        Text(sub)
                            .font(.system(size: 12))
                            .foregroundColor(Color.textSecondary)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.gray300)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileView()
}
