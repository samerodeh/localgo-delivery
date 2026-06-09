import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @EnvironmentObject var cart: CartStore
    @Environment(\.dismiss) var dismiss
    @State private var showCart = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    heroImage
                    infoBlock
                    menuSection
                    Spacer().frame(height: 100)
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Color.appBackground)

            // Sticky cart bar
            if cart.totalCount > 0 {
                cartBar
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(duration: 0.35), value: cart.totalCount)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 38, height: 38)
                        .background(Color.black.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(isPresented: $showCart) {
            CartView()
        }
    }

    // MARK: - Hero
    private var heroImage: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: restaurant.imageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray200)
            }
            .frame(maxWidth: .infinity, minHeight: 260)
            .clipped()

            LinearGradient(
                colors: [.clear, Color.navyDeep.opacity(0.55)],
                startPoint: .center,
                endPoint: .bottom
            )
        }
        .frame(height: 260)
    }

    // MARK: - Info block
    private var infoBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(restaurant.name)
                .font(.system(size: 22, weight: .black))
                .foregroundColor(Color.textPrimary)

            Text(restaurant.tags.joined(separator: " · "))
                .font(.system(size: 13))
                .foregroundColor(Color.textSecondary)

            // Meta chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    MetaChip(icon: "star.fill", text: String(format: "%.1f (%d)", restaurant.rating, restaurant.reviewCount), tint: .brand)
                    MetaChip(icon: "clock", text: restaurant.deliveryTime)
                    MetaChip(icon: "bicycle", text: restaurant.deliveryFee == "Free" ? "Free delivery" : restaurant.deliveryFee)
                    MetaChip(icon: "mappin", text: restaurant.distance)
                }
            }

            HStack(spacing: 4) {
                Image(systemName: "location")
                    .font(.system(size: 11))
                    .foregroundColor(Color.muted)
                Text(restaurant.address)
                    .font(.system(size: 12))
                    .foregroundColor(Color.muted)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
        .offset(y: -20)
        .cardShadow()
    }

    // MARK: - Menu
    private var menuSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Menu")
                .font(.system(size: 18, weight: .black))
                .foregroundColor(Color.textPrimary)
                .padding(.horizontal, 16)

            ForEach(restaurant.menu) { item in
                MenuItemRow(item: item, restaurant: restaurant)
            }
        }
        .padding(.top, -4)
    }

    // MARK: - Cart bar
    private var cartBar: some View {
        Button { showCart = true } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.brand)
                        .frame(width: 28, height: 28)
                    Text("\(cart.totalCount)")
                        .font(.system(size: 13, weight: .black))
                        .foregroundColor(.white)
                }
                Text("View Cart")
                    .font(.system(size: 16, weight: .bold))
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
            .shadow(color: Color.navyDeep.opacity(0.45), radius: 14, x: 0, y: 6)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

// MARK: - Menu item row
struct MenuItemRow: View {
    let item: MenuItem
    let restaurant: Restaurant
    @EnvironmentObject var cart: CartStore

    var qty: Int { cart.qty(for: item.id) }

    var body: some View {
        HStack(spacing: 0) {
            // Image
            AsyncImage(url: URL(string: item.imageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray200)
            }
            .frame(width: 90, height: 90)
            .clipped()

            // Info
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top) {
                    Text(item.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.textPrimary)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if item.isPopular {
                        Text("Popular")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color.brand)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(Color.brand.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
                Text(item.description)
                    .font(.system(size: 12))
                    .foregroundColor(Color.textSecondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Text(String(format: "$%.2f", item.price))
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(Color.textPrimary)
                    Spacer()
                    qtyControl
                }
            }
            .padding(12)
        }
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .subtleShadow()
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }

    private var qtyControl: some View {
        HStack(spacing: 8) {
            if qty > 0 {
                Button {
                    cart.remove(item)
                } label: {
                    Image(systemName: qty == 1 ? "trash" : "minus")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color.brand)
                        .frame(width: 28, height: 28)
                        .background(Color.brand.opacity(0.12))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.brand, lineWidth: 1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)

                Text("\(qty)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.textPrimary)
                    .frame(minWidth: 16)
            }

            Button {
                cart.add(item, from: restaurant)
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
                    .background(Color.brand)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Meta chip
struct MetaChip: View {
    let icon: String
    let text: String
    var tint: Color = .textSecondary

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundColor(tint)
            Text(text)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(tint == .brand ? Color.textPrimary : Color.textSecondary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.gray100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailView(restaurant: MockData.restaurants[0])
            .environmentObject(CartStore())
    }
}
