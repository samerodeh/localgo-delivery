import SwiftUI

// MARK: - OrdersView
struct OrdersView: View {
    private let activeOrder = MockData.activeOrder
    private let pastOrders = MockData.pastOrders

    var body: some View {
        NavigationStack {
            ZStack {
                Color.brandBackground.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Active Order
                        activeOrderCard
                            .padding(.horizontal, 20)

                        // Past Orders
                        pastOrdersSection
                            .padding(.horizontal, 20)
                            .padding(.bottom, 32)
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Orders")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: Active Order Card
    private var activeOrderCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header row
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Active Order")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.brandNavy)
                    Text(activeOrder.restaurantName)
                        .font(.subheadline)
                        .foregroundColor(.brandTextSecondary)
                }

                Spacer()

                if let eta = activeOrder.estimatedTime {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 11))
                            .foregroundColor(.brandOrange)
                        Text("ETA \(eta)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.brandOrange)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.brandOrange.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }

            // Progress tracker
            OrderProgressTracker(status: activeOrder.status)

            Divider()

            // Restaurant info + items
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: activeOrder.restaurantImage)) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().scaledToFill()
                    default:
                        Rectangle().fill(Color.brandGray100)
                    }
                }
                .frame(width: 52, height: 52)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 4) {
                    ForEach(activeOrder.items) { orderItem in
                        Text("\(orderItem.qty)x \(orderItem.name)")
                            .font(.system(size: 13))
                            .foregroundColor(.brandNavy)
                    }
                }

                Spacer()

                Text(String(format: "$%.2f", activeOrder.total))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.brandNavy)
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 3)
    }

    // MARK: Past Orders
    private var pastOrdersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Past Orders")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.brandNavy)

            ForEach(pastOrders) { order in
                PastOrderCard(order: order)
            }
        }
    }
}

// MARK: - OrderProgressTracker
struct OrderProgressTracker: View {
    let status: OrderStatus

    private let steps: [OrderStatus] = [.placing, .preparing, .pickingUp, .onTheWay, .delivered]

    private var currentIndex: Int {
        steps.firstIndex(of: status) ?? 0
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                // Step circle
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(index <= currentIndex ? Color.brandOrange : Color.brandGray100)
                            .frame(width: 28, height: 28)

                        if index < currentIndex {
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        } else if index == currentIndex {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .fill(Color.brandMuted)
                                .frame(width: 8, height: 8)
                        }
                    }

                    Text(step.label)
                        .font(.system(size: 9, weight: index <= currentIndex ? .semibold : .regular))
                        .foregroundColor(index <= currentIndex ? .brandNavy : .brandMuted)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 52)
                }

                // Connector line (not after last step)
                if index < steps.count - 1 {
                    Rectangle()
                        .fill(index < currentIndex ? Color.brandOrange : Color.brandGray100)
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

// MARK: - PastOrderCard
struct PastOrderCard: View {
    let order: Order
    @State private var reordering: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            // Restaurant image
            AsyncImage(url: URL(string: order.restaurantImage)) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().scaledToFill()
                default:
                    Rectangle().fill(Color.brandGray100)
                }
            }
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            // Info
            VStack(alignment: .leading, spacing: 3) {
                Text(order.restaurantName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.brandNavy)

                let itemSummary = order.items.prefix(2)
                    .map { "\($0.qty)x \($0.name)" }
                    .joined(separator: ", ")
                let suffix = order.items.count > 2 ? " +\(order.items.count - 2) more" : ""
                Text(itemSummary + suffix)
                    .font(.system(size: 11))
                    .foregroundColor(.brandTextSecondary)
                    .lineLimit(1)

                Text(order.date)
                    .font(.system(size: 11))
                    .foregroundColor(.brandMuted)
            }

            Spacer()

            // Right side
            VStack(alignment: .trailing, spacing: 6) {
                Text(String(format: "$%.2f", order.total))
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.brandNavy)

                Button {
                    reordering = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        reordering = false
                    }
                } label: {
                    if reordering {
                        ProgressView()
                            .scaleEffect(0.7)
                            .frame(width: 70, height: 28)
                    } else {
                        Text("Reorder")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 70, height: 28)
                            .background(Color.brandOrange)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
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
    OrdersView()
}
