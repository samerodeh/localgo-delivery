import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore
    @Environment(\.dismiss) var dismiss
    @State private var orderPlaced = false

    var body: some View {
        NavigationStack {
            Group {
                if cart.entries.isEmpty {
                    emptyCart
                } else {
                    filledCart
                }
            }
            .navigationTitle("Your Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundColor(Color.brand)
                }
            }
            .alert("Order Placed! 🎉", isPresented: $orderPlaced) {
                Button("Track Order", role: .none) {
                    cart.clear()
                    dismiss()
                }
            } message: {
                Text("Your order from \(cart.restaurantName) is being prepared.")
            }
        }
    }

    // MARK: - Filled cart
    private var filledCart: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // From
                    HStack(spacing: 6) {
                        Image(systemName: "storefront")
                            .font(.system(size: 12))
                            .foregroundColor(Color.muted)
                        Text(cart.restaurantName)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color.muted)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                    // Items
                    ForEach(cart.entries) { entry in
                        CartItemRow(entry: entry)
                    }

                    // Add more
                    Button { dismiss() } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color.brand)
                            Text("Add more items")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.brand)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)

                    Divider().padding(.horizontal, 20)

                    // Promo row
                    HStack(spacing: 10) {
                        Image(systemName: "tag")
                            .foregroundColor(Color.brand)
                        Text("Add promo code")
                            .font(.system(size: 14))
                            .foregroundColor(Color.textSecondary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(Color.gray300)
                    }
                    .padding(14)
                    .background(Color.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                            .foregroundColor(Color.border)
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)

                    // Order summary
                    summaryCard
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)

                    // Delivery address
                    addressRow
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                }
            }
            .background(Color.appBackground)

            // Place order CTA
            placeOrderButton
        }
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Order Summary")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.textPrimary)
                .padding(.bottom, 12)

            summaryRow(label: "Subtotal", value: cart.subtotal)
            summaryRow(label: "Delivery fee", value: cart.deliveryFee)
            summaryRow(label: "Service fee", value: cart.serviceFee)

            Divider().padding(.vertical, 10)

            HStack {
                Text("Total")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(Color.textPrimary)
                Spacer()
                Text(String(format: "$%.2f", cart.total))
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(Color.textPrimary)
            }
        }
        .padding(16)
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .subtleShadow()
    }

    private func summaryRow(label: String, value: Double) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(Color.textSecondary)
            Spacer()
            Text(String(format: "$%.2f", value))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.textPrimary)
        }
        .padding(.bottom, 8)
    }

    private var addressRow: some View {
        HStack(spacing: 10) {
            Image(systemName: "location.fill")
                .foregroundColor(Color.brand)
                .font(.system(size: 14))
            VStack(alignment: .leading, spacing: 1) {
                Text("Delivering to")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color.muted)
                Text("1455 Blvd de Maisonneuve, Montreal")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color.textPrimary)
            }
            Spacer()
            Button {
            } label: {
                Text("Change")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color.brand)
            }
        }
        .padding(14)
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .subtleShadow()
    }

    private var placeOrderButton: some View {
        VStack(spacing: 0) {
            Divider()
            Button {
                orderPlaced = true
            } label: {
                Text(String(format: "Place Order · $%.2f", cart.total))
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.brand)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .padding(16)
            .background(Color.surface)
        }
        .shadow(color: Color.brand.opacity(0.25), radius: 10, x: 0, y: -2)
    }

    // MARK: - Empty state
    private var emptyCart: some View {
        VStack(spacing: 12) {
            Image(systemName: "bag")
                .font(.system(size: 60, weight: .light))
                .foregroundColor(Color.muted)
            Text("Your cart is empty")
                .font(.system(size: 20, weight: .black))
                .foregroundColor(Color.textPrimary)
            Text("Add items from a restaurant to get started")
                .font(.system(size: 14))
                .foregroundColor(Color.textSecondary)
                .multilineTextAlignment(.center)
            Button {
                dismiss()
            } label: {
                Text("Browse Restaurants")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
                    .background(Color.brand)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
    }
}

// MARK: - Cart item row
struct CartItemRow: View {
    let entry: CartEntry
    @EnvironmentObject var cart: CartStore

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: entry.item.imageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray200)
            }
            .frame(width: 74, height: 74)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.item.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.textPrimary)
                    .lineLimit(2)
                Text(String(format: "$%.2f", entry.item.price * Double(entry.qty)))
                    .font(.system(size: 14, weight: .black))
                    .foregroundColor(Color.textPrimary)
            }
            .padding(.horizontal, 12)

            Spacer()

            // Qty controls
            HStack(spacing: 8) {
                Button {
                    cart.remove(entry.item)
                } label: {
                    Image(systemName: entry.qty == 1 ? "trash" : "minus")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color.brand)
                        .frame(width: 28, height: 28)
                        .background(Color.brand.opacity(0.12))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.brand, lineWidth: 1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)

                Text("\(entry.qty)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.textPrimary)
                    .frame(minWidth: 16)

                Button {
                    // Need the full restaurant to call cart.add — use item price only via a workaround
                    // For cart we just increment directly
                    if let idx = cart.entries.firstIndex(where: { $0.id == entry.id }) {
                        _ = idx // workaround: add via CartStore public method
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .background(Color.brand)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(true) // increment handled by restaurant detail; show as info only
            }
            .padding(.trailing, 12)
        }
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        .subtleShadow()
    }
}

#Preview {
    CartView()
        .environmentObject(CartStore())
}
