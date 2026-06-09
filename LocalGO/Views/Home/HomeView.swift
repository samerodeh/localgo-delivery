import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cart: CartStore
    @State private var search = ""
    @State private var activeCategory = "all"
    @State private var showCart = false

    var filtered: [Restaurant] {
        MockData.restaurants.filter { r in
            let matchCat = activeCategory == "all" || r.category == activeCategory
            let matchSearch = search.isEmpty ||
                r.name.localizedCaseInsensitiveContains(search) ||
                r.tags.contains { $0.localizedCaseInsensitiveContains(search) }
            return matchCat && matchSearch
        }
    }

    var topPicks: [Restaurant] {
        MockData.restaurants.filter { $0.badge == .popular || $0.rating >= 4.8 }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // ── Header ──────────────────────────────────────────
                    headerBar

                    // ── Scrollable content ───────────────────────────────
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            greetingSection
                            searchBar
                            categoryRow
                            if activeCategory == "all" && search.isEmpty {
                                topPicksSection
                            }
                            nearYouSection
                        }
                        .padding(.bottom, 30)
                    }
                    .background(Color.appBackground)
                    .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
                }
                .background(Color.navyDeep.ignoresSafeArea())

                // Cart FAB
                if cart.totalCount > 0 {
                    cartFAB
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showCart) {
                CartView()
            }
        }
    }

    // MARK: - Sub-views

    private var headerBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Label("Delivering to", systemImage: "location.fill")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color.muted)
                HStack(spacing: 4) {
                    Text("Montreal, QC")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            Spacer()
            Button {
                showCart = true
            } label: {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bag")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.navyMid)
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                    if cart.totalCount > 0 {
                        Text("\(cart.totalCount)")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16)
                            .background(Color.brand)
                            .clipShape(Circle())
                            .offset(x: 4, y: -4)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }

    private var greetingSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Hey, Samer 👋")
                .font(.system(size: 24, weight: .black))
                .foregroundColor(Color.textPrimary)
            Text("What are you craving today?")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.textSecondary)
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 18)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color.muted)
            TextField("Search restaurants, cuisines...", text: $search)
                .font(.system(size: 15))
                .foregroundColor(Color.textPrimary)
                .autocorrectionDisabled()
            if !search.isEmpty {
                Button { search = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.muted)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.border, lineWidth: 1.5)
        )
        .cardShadow()
        .padding(.horizontal, 20)
        .padding(.bottom, 18)
    }

    private var categoryRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(MockData.categories) { cat in
                    CategoryChipView(
                        label: cat.label,
                        icon: cat.icon,
                        isActive: activeCategory == cat.id
                    ) {
                        withAnimation(.spring(duration: 0.3)) {
                            activeCategory = cat.id
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 16)
    }

    private var topPicksSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Top Picks", action: "See all")
                .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(topPicks) { r in
                        NavigationLink(destination: RestaurantDetailView(restaurant: r)) {
                            RestaurantCardView(restaurant: r, style: .horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 4)
            }
        }
        .padding(.bottom, 24)
    }

    private var nearYouSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(
                title: activeCategory == "all" && search.isEmpty
                    ? "Near You"
                    : "Results (\(filtered.count))",
                action: activeCategory == "all" && search.isEmpty ? "See all" : nil
            )
            .padding(.horizontal, 20)

            if filtered.isEmpty {
                emptyState
            } else {
                VStack(spacing: 0) {
                    ForEach(filtered) { r in
                        NavigationLink(destination: RestaurantDetailView(restaurant: r)) {
                            RestaurantCardView(restaurant: r, style: .vertical)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40, weight: .light))
                .foregroundColor(Color.muted)
            Text("No restaurants found")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.textPrimary)
            Text("Try a different search or category")
                .font(.system(size: 13))
                .foregroundColor(Color.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    private var cartFAB: some View {
        Button { showCart = true } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.brand)
                        .frame(width: 26, height: 26)
                    Text("\(cart.totalCount)")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.white)
                }
                Text("View Cart")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text(String(format: "$%.2f", cart.total))
                    .font(.system(size: 15, weight: .black))
                    .foregroundColor(Color.brand)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.navyDeep)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.navyDeep.opacity(0.4), radius: 14, x: 0, y: 6)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring(duration: 0.35), value: cart.totalCount)
    }
}

// MARK: - Section header helper
struct SectionHeader: View {
    let title: String
    var action: String? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .black))
                .foregroundColor(Color.textPrimary)
            Spacer()
            if let action {
                Button(action: {}) {
                    Text(action)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color.brand)
                }
            }
        }
    }
}

// MARK: - Rounded corner helper
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    HomeView()
        .environmentObject(CartStore())
}
