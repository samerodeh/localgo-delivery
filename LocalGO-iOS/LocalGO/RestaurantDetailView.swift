import SwiftUI

// MARK: - RestaurantDetailView
struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @EnvironmentObject private var cartStore: CartStore
    @Environment(\.dismiss) private var dismiss
    @State private var showCart: Bool = false

    // Unique ordered sections
    private var sections: [String] {
        var seen = Set<String>()
        var result: [String] = []
        for item in restaurant.menu {
            if let sec = item.section, !seen.contains(sec) {
                seen.insert(sec)
                result.append(sec)
            }
        }
        return result
    }

    private var hasSections: Bool {
        !sections.isEmpty
    }

    private var showFloatingBar: Bool {
        cartStore.totalCount > 0 && cartStore.restaurant?.id == restaurant.id
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.brandBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Hero
                    heroSection

                    // Info Card
                    infoCard
                        .padding(.horizontal, 16)
                        .offset(y: -20)

                    // Menu
                    menuSection
                        .padding(.horizontal, 16)
                        .padding(.top, -4)
                        .padding(.bottom, showFloatingBar ? 100 : 32)
                }
            }
            .ignoresSafeArea(edges: .top)

            // Floating Cart Bar
            if showFloatingBar {
                floatingCartBar
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showCart) {
            CartView()
        }
        .animation(.spring(response: 0.35), value: showFloatingBar)
    }

    // MARK: Hero
    private var heroSection: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: restaurant.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Rectangle().fill(Color.brandGray100)
                default:
                    Rectangle().fill(Color.brandGray100).overlay { ProgressView() }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 260)
            .clipped()
            .overlay {
                LinearGradient(
                    colors: [Color.brandNavy.opacity(0.5), .clear],
                    startPoint: .top,
                    endPoint: .center
                )
            }

            // Back button
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
            }
            .padding(.top, 52)
            .padding(.leading, 20)
        }
    }

    // MARK: Info Card
    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.brandNavy)

            Text(restaurant.tags.joined(separator: " · "))
                .font(.subheadline)
                .foregroundColor(.brandTextSecondary)

            HStack(spacing: 8) {
                MetaChip(icon: "star.fill", text: "\(String(format: "%.1f", restaurant.rating)) (\(restaurant.reviewCount))", orange: true)
                MetaChip(icon: "clock", text: restaurant.deliveryTime)
                MetaChip(icon: "bag", text: restaurant.deliveryFee == 0 ? "Free delivery" : String(format: "$%.2f delivery", restaurant.deliveryFee))
            }

            Divider()

            HStack(spacing: 6) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 13))
                    .foregroundColor(.brandOrange)
                Text(restaurant.address)
                    .font(.caption)
                    .foregroundColor(.brandTextSecondary)
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }

    // MARK: Menu
    private var menuSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Menu")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.brandNavy)
                .padding(.bottom, 14)

            if hasSections {
                ForEach(sections, id: \.self) { section in
                    // Section header
                    Text(section)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.brandTextSecondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.brandGray100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom, 10)

                    let sectionItems = restaurant.menu.filter { $0.section == section }
                    ForEach(sectionItems) { item in
                        MenuItemRow(item: item, restaurant: restaurant)
                            .padding(.bottom, 12)
                    }

                    Spacer().frame(height: 8)
                }
            } else {
                ForEach(restaurant.menu) { item in
                    MenuItemRow(item: item, restaurant: restaurant)
                        .padding(.bottom, 12)
                }
            }
        }
    }

    // MARK: Floating Cart Bar
    private var floatingCartBar: some View {
        Button {
            showCart = true
        } label: {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.brandOrange)
                        .frame(width: 28, height: 28)
                    Text("\(cartStore.totalCount)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }

                Text("View Cart")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()

                Text(String(format: "$%.2f", cartStore.totalPrice))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.brandOrange)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(Color.brandNavy)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.brandNavy.opacity(0.35), radius: 12, x: 0, y: 4)
        }
    }
}

// MARK: - MetaChip
struct MetaChip: View {
    let icon: String
    let text: String
    var orange: Bool = false

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundColor(orange ? .brandOrange : .brandMuted)
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.brandTextSecondary)
        }
        .padding(.horizontal, 9)
        .padding(.vertical, 5)
        .background(Color.brandGray100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - MenuItemRow
struct MenuItemRow: View {
    let item: MenuItem
    let restaurant: Restaurant
    @EnvironmentObject private var cartStore: CartStore

    private var qty: Int {
        cartStore.items[item.id] ?? 0
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Image
            AsyncImage(url: URL(string: item.image)) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().scaledToFill()
                case .failure:
                    Rectangle().fill(Color.brandGray100)
                default:
                    Rectangle().fill(Color.brandGray100).overlay { ProgressView().scaleEffect(0.6) }
                }
            }
            .frame(width: 90, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Content
            VStack(alignment: .leading, spacing: 4) {
                // Name row
                HStack(spacing: 6) {
                    Text(item.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.brandNavy)
                        .fixedSize(horizontal: false, vertical: true)

                    if item.popular {
                        Text("Popular")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.brandOrange)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color.brandOrange.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }

                // Description
                Text(item.description)
                    .font(.system(size: 12))
                    .foregroundColor(.brandTextSecondary)
                    .lineLimit(2)

                Spacer(minLength: 4)

                // Price + Qty controls
                HStack {
                    Text(String(format: "$%.2f", item.price))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.brandNavy)

                    Spacer()

                    if qty == 0 {
                        Button {
                            cartStore.add(item, from: restaurant)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.brandOrange)
                        }
                    } else {
                        HStack(spacing: 10) {
                            Button {
                                cartStore.remove(item)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.brandNavy)
                            }

                            Text("\(qty)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.brandNavy)
                                .frame(minWidth: 18)

                            Button {
                                cartStore.add(item, from: restaurant)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.brandOrange)
                            }
                        }
                    }
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 1)
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailView(restaurant: MockData.restaurants[0])
            .environmentObject(CartStore())
    }
}
