import SwiftUI

enum CardStyle { case vertical, horizontal }

struct RestaurantCardView: View {
    let restaurant: Restaurant
    var style: CardStyle = .vertical

    var body: some View {
        switch style {
        case .vertical:   verticalCard
        case .horizontal: horizontalCard
        }
    }

    // MARK: - Vertical (full-width list card)
    private var verticalCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageSection(height: 160)
            infoSection
        }
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .cardShadow()
    }

    // MARK: - Horizontal (compact carousel card)
    private var horizontalCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageSection(height: 130)
            infoSection
        }
        .frame(width: 220)
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .cardShadow()
    }

    // MARK: - Shared sub-views
    private func imageSection(height: CGFloat) -> some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: restaurant.imageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray200)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipped()

            if let badge = restaurant.badge {
                badgeView(badge)
                    .padding(10)
            }
        }
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(restaurant.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.textPrimary)
                .lineLimit(1)

            Text(restaurant.tags.joined(separator: " · "))
                .font(.system(size: 12))
                .foregroundColor(Color.textSecondary)
                .lineLimit(1)

            metaRow
        }
        .padding(14)
    }

    private var metaRow: some View {
        HStack(spacing: 6) {
            // Rating
            Image(systemName: "star.fill")
                .font(.system(size: 11))
                .foregroundColor(Color.brand)
            Text(String(format: "%.1f", restaurant.rating))
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color.textPrimary)
            Text("(\(restaurant.reviewCount))")
                .font(.system(size: 11))
                .foregroundColor(Color.muted)

            dot

            // Delivery time
            Image(systemName: "clock")
                .font(.system(size: 11))
                .foregroundColor(Color.muted)
            Text(restaurant.deliveryTime)
                .font(.system(size: 12))
                .foregroundColor(Color.textSecondary)

            dot

            // Fee
            Text(restaurant.deliveryFee == "Free" ? "Free delivery" : restaurant.deliveryFee)
                .font(.system(size: 12))
                .foregroundColor(Color.textSecondary)
                .lineLimit(1)
        }
    }

    private var dot: some View {
        Circle()
            .fill(Color.gray300)
            .frame(width: 3, height: 3)
    }

    @ViewBuilder
    private func badgeView(_ badge: Restaurant.Badge) -> some View {
        let (bg, fg): (Color, Color) = {
            switch badge {
            case .popular: return (.brand, .white)
            case .new:     return (.success, .white)
            case .deal:    return (.navy, .brand)
            }
        }()
        Text(badge.rawValue)
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(fg)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(bg)
            .clipShape(Capsule())
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            RestaurantCardView(restaurant: MockData.restaurants[0], style: .vertical)
            RestaurantCardView(restaurant: MockData.restaurants[1], style: .vertical)
        }
        .padding()
    }
    .background(Color.appBackground)
}
