import SwiftUI

// MARK: - HomeView
struct HomeView: View {
    @EnvironmentObject private var cartStore: CartStore

    @State private var searchText: String = ""
    @State private var selectedCategory: String = "all"
    @State private var showCart: Bool = false

    private var filteredRestaurants: [Restaurant] {
        MockData.restaurants.filter { restaurant in
            let matchesCategory = selectedCategory == "all" || restaurant.category == selectedCategory
            let matchesSearch: Bool
            if searchText.isEmpty {
                matchesSearch = true
            } else {
                let q = searchText.lowercased()
                matchesSearch = restaurant.name.lowercased().contains(q)
                    || restaurant.tags.contains(where: { $0.lowercased().contains(q) })
            }
            return matchesCategory && matchesSearch
        }
    }

    private var isFiltered: Bool {
        !searchText.isEmpty || selectedCategory != "all"
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.brandBackground.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Header
                        headerSection
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                            .padding(.bottom, 12)

                        // Search Bar
                        searchBar
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)

                        // Category Chips
                        categoryChips
                            .padding(.bottom, 20)

                        // Top Picks (only when not filtering)
                        if !isFiltered {
                            topPicksSection
                                .padding(.bottom, 24)
                        }

                        // All Restaurants
                        restaurantsSection
                            .padding(.horizontal, 20)
                            .padding(.bottom, 32)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showCart) {
                CartView()
            }
        }
    }

    // MARK: Header
    private var headerSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.brandOrange)
                    Text("Montreal, QC")
                        .font(.caption)
                        .foregroundColor(.brandTextSecondary)
                }
                Text("Hey, Samer 👋")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.brandNavy)
            }

            Spacer()

            // Cart button
            Button {
                showCart = true
            } label: {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bag.fill")
                        .font(.title3)
                        .foregroundColor(.brandNavy)
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)

                    if cartStore.totalCount > 0 {
                        Text("\(cartStore.totalCount)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .frame(minWidth: 18, minHeight: 18)
                            .background(Color.brandOrange)
                            .clipShape(Circle())
                            .offset(x: 4, y: -4)
                    }
                }
            }
        }
    }

    // MARK: Search Bar
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.brandMuted)
            TextField("Search restaurants, cuisines...", text: $searchText)
                .font(.subheadline)
                .foregroundColor(.brandNavy)
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.brandMuted)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }

    // MARK: Category Chips
    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(MockData.categories) { category in
                    CategoryChipView(
                        category: category,
                        isSelected: selectedCategory == category.id
                    ) {
                        selectedCategory = category.id
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: Top Picks
    private var topPicksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Top Picks")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.brandNavy)
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(MockData.restaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            TopPickCard(restaurant: restaurant)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: Restaurants Section
    private var restaurantsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(isFiltered ? "Results (\(filteredRestaurants.count))" : "All Restaurants")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.brandNavy)

            if filteredRestaurants.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 44))
                        .foregroundColor(.brandMuted)
                    Text("No restaurants found")
                        .font(.subheadline)
                        .foregroundColor(.brandTextSecondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                LazyVStack(spacing: 14) {
                    ForEach(filteredRestaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            RestaurantCardView(restaurant: restaurant)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

// MARK: - CategoryChipView
struct CategoryChipView: View {
    let category: RestaurantCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.system(size: 13))
                Text(category.label)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(isSelected ? .white : .brandNavy)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? Color.brandNavy : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: .black.opacity(isSelected ? 0 : 0.06), radius: 4, x: 0, y: 1)
        }
    }
}

// MARK: - TopPickCard
struct TopPickCard: View {
    let restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Hero image
            AsyncImage(url: URL(string: restaurant.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Rectangle().fill(Color.brandGray100)
                default:
                    Rectangle().fill(Color.brandGray100).overlay {
                        ProgressView()
                    }
                }
            }
            .frame(width: 180, height: 120)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(restaurant.name)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.brandNavy)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.brandOrange)
                    Text(String(format: "%.1f", restaurant.rating))
                        .font(.system(size: 11))
                        .foregroundColor(.brandTextSecondary)
                    Text("·")
                        .foregroundColor(.brandMuted)
                    Text(restaurant.deliveryTime)
                        .font(.system(size: 11))
                        .foregroundColor(.brandTextSecondary)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
        }
        .frame(width: 180)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}

// MARK: - RestaurantCardView
struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        HStack(spacing: 14) {
            // Thumbnail
            AsyncImage(url: URL(string: restaurant.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Rectangle().fill(Color.brandGray100)
                default:
                    Rectangle().fill(Color.brandGray100).overlay {
                        ProgressView().scaleEffect(0.7)
                    }
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Info
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(restaurant.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.brandNavy)
                    Spacer()
                    if let badge = restaurant.badge {
                        BadgePill(badge: badge)
                    }
                }

                // Tags
                Text(restaurant.tags.prefix(3).joined(separator: " · "))
                    .font(.system(size: 12))
                    .foregroundColor(.brandTextSecondary)
                    .lineLimit(1)

                // Meta chips
                HStack(spacing: 6) {
                    SmallChip(icon: "star.fill", text: String(format: "%.1f", restaurant.rating), orange: true)
                    SmallChip(icon: "clock", text: restaurant.deliveryTime)
                    SmallChip(icon: "bag", text: restaurant.deliveryFee == 0 ? "Free" : String(format: "$%.2f", restaurant.deliveryFee))
                }
                .padding(.top, 2)
            }
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}

// MARK: - BadgePill
struct BadgePill: View {
    let badge: RestaurantBadge

    private var color: Color {
        switch badge {
        case .popular: return .brandOrange
        case .new:     return Color(red: 0.1, green: 0.7, blue: 0.5)
        case .deal:    return Color(red: 0.55, green: 0.2, blue: 0.9)
        }
    }

    var body: some View {
        Text(badge.rawValue)
            .font(.system(size: 10, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

// MARK: - SmallChip
struct SmallChip: View {
    let icon: String
    let text: String
    var orange: Bool = false

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(size: 9))
                .foregroundColor(orange ? .brandOrange : .brandMuted)
            Text(text)
                .font(.system(size: 11))
                .foregroundColor(.brandTextSecondary)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 3)
        .background(Color.brandGray100)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    HomeView()
        .environmentObject(CartStore())
}
