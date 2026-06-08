import SwiftUI

// MARK: - CartView
struct CartView: View {
    @EnvironmentObject private var cartStore: CartStore
    @Environment(\.dismiss) private var dismiss

    @State private var promoCode: String = ""
    @State private var promoApplied: Bool = false
    @State private var showOrderConfirmation: Bool = false

    private let deliveryFee: Double = 2.49
    private let serviceRatePct: Double = 0.05

    private var subtotal: Double { cartStore.totalPrice }
    private var serviceFee: Double { subtotal * serviceRatePct }
    private var total: Double { subtotal + deliveryFee + serviceFee }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.brandBackground.ignoresSafeArea()

                if cartStore.cartLines.isEmpty {
                    emptyState
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            // Restaurant name
                            if let rest = cartStore.restaurant {
                                HStack(spacing: 8) {
                                    Image(systemName: "fork.knife")
                                        .foregroundColor(.brandOrange)
                                    Text(rest.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.brandNavy)
                                    Spacer()
                                    Button {
                                        cartStore.clear()
                                    } label: {
                                        Text("Clear")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 8)
                            }

                            // Cart Items
                            VStack(spacing: 12) {
                                ForEach(cartStore.cartLines, id: \.item.id) { line in
                                    CartItemRow(item: line.item, qty: line.qty)
                                }
                            }
                            .padding(.horizontal, 20)

                            // Promo Code
                            promoSection
                                .padding(.horizontal, 20)

                            // Order Summary
                            orderSummaryCard
                                .padding(.horizontal, 20)
                                .padding(.bottom, 110)
                        }
                    }

                    // Place Order Button
                    VStack(spacing: 0) {
                        Divider()
                        Button {
                            showOrderConfirmation = true
                        } label: {
                            Text(String(format: "Place Order · $%.2f", total))
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.brandNavy)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                        .padding(.bottom, 28)
                        .background(Color.brandBackground)
                    }
                }
            }
            .navigationTitle("Your Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.brandMuted)
                            .font(.title3)
                    }
                }
            }
            .alert("Order Placed!", isPresented: $showOrderConfirmation) {
                Button("OK") {
                    cartStore.clear()
                    dismiss()
                }
            } message: {
                Text("Your order has been placed successfully. Estimated delivery: 25-35 min.")
            }
        }
    }

    // MARK: Empty State
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "bag")
                .font(.system(size: 60))
                .foregroundColor(.brandMuted)
            Text("Your cart is empty")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.brandNavy)
            Text("Add items from a restaurant to get started.")
                .font(.subheadline)
                .foregroundColor(.brandTextSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: Promo Code
    private var promoSection: some View {
        HStack(spacing: 10) {
            Image(systemName: "tag")
                .foregroundColor(.brandOrange)
            TextField("Promo code", text: $promoCode)
                .font(.subheadline)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.characters)

            if promoApplied {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color(red: 0.1, green: 0.7, blue: 0.5))
            } else {
                Button("Apply") {
                    if !promoCode.isEmpty {
                        promoApplied = true
                    }
                }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.brandOrange)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 1)
    }

    // MARK: Order Summary
    private var orderSummaryCard: some View {
        VStack(spacing: 0) {
            Text("Order Summary")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.brandNavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)

            SummaryRow(label: "Subtotal", value: String(format: "$%.2f", subtotal))
            Divider().padding(.vertical, 8)
            SummaryRow(label: "Delivery Fee", value: String(format: "$%.2f", deliveryFee))
            Divider().padding(.vertical, 8)
            SummaryRow(label: "Service Fee (5%)", value: String(format: "$%.2f", serviceFee))

            if promoApplied {
                Divider().padding(.vertical, 8)
                SummaryRow(label: "Promo Discount", value: "-$2.00", valueColor: Color(red: 0.1, green: 0.7, blue: 0.5))
            }

            Divider().padding(.vertical, 8)
            SummaryRow(
                label: "Total",
                value: String(format: "$%.2f", promoApplied ? total - 2.0 : total),
                bold: true
            )
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

// MARK: - CartItemRow
struct CartItemRow: View {
    let item: MenuItem
    let qty: Int
    @EnvironmentObject private var cartStore: CartStore

    var body: some View {
        HStack(spacing: 12) {
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
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.brandNavy)
                    .lineLimit(2)
                Text(String(format: "$%.2f each", item.price))
                    .font(.system(size: 11))
                    .foregroundColor(.brandTextSecondary)
            }

            Spacer()

            // Qty controls
            VStack(alignment: .trailing, spacing: 4) {
                Text(String(format: "$%.2f", item.price * Double(qty)))
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.brandNavy)

                HStack(spacing: 8) {
                    Button {
                        cartStore.remove(item)
                    } label: {
                        Image(systemName: qty == 1 ? "trash.circle.fill" : "minus.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(qty == 1 ? .red : .brandNavy)
                    }

                    Text("\(qty)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.brandNavy)
                        .frame(minWidth: 16)

                    Button {
                        if let restaurant = cartStore.restaurant,
                           let fullItem = restaurant.menu.first(where: { $0.id == item.id }) {
                            cartStore.add(fullItem, from: restaurant)
                        } else {
                            // fallback using stored snapshot
                            cartStore.menuItemsMap[item.id] = item
                            cartStore.items[item.id, default: 0] += 1
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.brandOrange)
                    }
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 1)
    }
}

// MARK: - SummaryRow
struct SummaryRow: View {
    let label: String
    let value: String
    var bold: Bool = false
    var valueColor: Color = .brandNavy

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13, weight: bold ? .bold : .regular))
                .foregroundColor(bold ? .brandNavy : .brandTextSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: bold ? .bold : .medium))
                .foregroundColor(bold ? valueColor : valueColor)
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartStore())
}
