import SwiftUI

struct OrdersView: View {
    let activeOrder = MockData.activeOrder
    let pastOrders  = MockData.pastOrders

    var body: some View {
        ZStack(alignment: .top) {
            // Dark top bar
            Color.navyDeep
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("My Orders")
                        .font(.system(size: 22, weight: .black))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Active order
                        sectionBlock(title: "Active") {
                            ActiveOrderView(order: activeOrder)
                        }

                        // Past orders
                        sectionBlock(title: "Past Orders") {
                            VStack(spacing: 12) {
                                ForEach(pastOrders) { order in
                                    PastOrderCard(order: order)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 30)
                }
                .background(Color.appBackground)
                .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
            }
        }
        .background(Color.navyDeep.ignoresSafeArea())
    }

    private func sectionBlock<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .black))
                .foregroundColor(Color.textPrimary)
            content()
        }
    }
}

// MARK: - Active Order Tracker
struct ActiveOrderView: View {
    let order: Order

    private let steps: [OrderStatus] = [.placing, .preparing, .pickingUp, .onTheWay, .delivered]

    private func isActive(_ step: OrderStatus) -> Bool {
        step.rawValue <= order.status.rawValue
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // Top row
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("ACTIVE ORDER")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(Color.muted)
                        .tracking(0.8)
                    Text(order.restaurantName)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                }
                Spacer()
                if let eta = order.estimatedMinutes {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 11))
                        Text("\(eta) min")
                            .font(.system(size: 13, weight: .bold))
                    }
                    .foregroundColor(Color.brand)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.brand.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.brand, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            // Step tracker
            HStack(alignment: .top, spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.element.rawValue) { i, step in
                    // Step dot + label
                    VStack(spacing: 4) {
                        ZStack {
                            Circle()
                                .fill(isActive(step) ? Color.brand : Color.navyLight)
                                .frame(width: 28, height: 28)
                            Image(systemName: step.icon)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(isActive(step) ? .white : Color.gray400)
                        }
                        Text(step.label)
                            .font(.system(size: 9, weight: isActive(step) ? .semibold : .regular))
                            .foregroundColor(isActive(step) ? Color.brandLight : Color.muted)
                            .multilineTextAlignment(.center)
                            .frame(width: 48)
                    }
                    .frame(maxWidth: .infinity)

                    // Connector line (between dots)
                    if i < steps.count - 1 {
                        Rectangle()
                            .fill(isActive(steps[i + 1]) ? Color.brand : Color.navyLight)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 13)
                            .padding(.horizontal, -8)
                    }
                }
            }
        }
        .padding(18)
        .background(Color.navyMid)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Past Order Card
struct PastOrderCard: View {
    let order: Order

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: order.restaurantImageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray200)
            }
            .frame(width: 70, height: 70)
            .clipped()

            VStack(alignment: .leading, spacing: 3) {
                Text(order.restaurantName)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.textPrimary)
                Text(order.items.map { "\($0.qty)× \($0.name)" }.joined(separator: ", "))
                    .font(.system(size: 12))
                    .foregroundColor(Color.textSecondary)
                    .lineLimit(1)
                HStack(spacing: 8) {
                    Text(order.date)
                        .font(.system(size: 12))
                        .foregroundColor(Color.muted)
                    Text(String(format: "$%.2f", order.total))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color.textPrimary)
                }
            }
            .padding(.horizontal, 12)

            Spacer()

            Button {} label: {
                Text("Reorder")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color.brand)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.brand.opacity(0.12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.brand, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .padding(.trailing, 12)
        }
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .subtleShadow()
    }
}

#Preview {
    OrdersView()
}
