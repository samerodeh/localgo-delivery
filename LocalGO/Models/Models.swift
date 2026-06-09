import Foundation

// MARK: - Category
struct FoodCategory: Identifiable {
    let id: String
    let label: String
    let icon: String  // SF Symbol name
}

// MARK: - Restaurant
struct Restaurant: Identifiable {
    let id: String
    let name: String
    let category: String
    let imageURL: String
    let rating: Double
    let reviewCount: Int
    let deliveryTime: String
    let deliveryFee: String
    let minOrder: String
    let distance: String
    let badge: Badge?
    let tags: [String]
    let address: String
    let menu: [MenuItem]

    enum Badge: String {
        case popular = "Popular"
        case new = "New"
        case deal = "Deal"
    }
}

// MARK: - Menu Item
struct MenuItem: Identifiable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let isPopular: Bool
}

// MARK: - Order
struct Order: Identifiable {
    let id: String
    let restaurantName: String
    let restaurantImageURL: String
    let status: OrderStatus
    let items: [OrderItem]
    let total: Double
    let date: String
    let deliveryAddress: String
    let estimatedMinutes: Int?
}

struct OrderItem {
    let name: String
    let qty: Int
    let price: Double
}

enum OrderStatus: Int, CaseIterable {
    case placing = 0
    case preparing
    case pickingUp
    case onTheWay
    case delivered
    case cancelled

    var label: String {
        switch self {
        case .placing:    return "Placed"
        case .preparing:  return "Preparing"
        case .pickingUp:  return "Picked Up"
        case .onTheWay:   return "On the Way"
        case .delivered:  return "Delivered"
        case .cancelled:  return "Cancelled"
        }
    }

    var icon: String {
        switch self {
        case .placing:    return "checkmark.circle.fill"
        case .preparing:  return "flame.fill"
        case .pickingUp:  return "bicycle"
        case .onTheWay:   return "location.fill"
        case .delivered:  return "checkmark.seal.fill"
        case .cancelled:  return "xmark.circle.fill"
        }
    }

    var activeSteps: [OrderStatus] {
        [.placing, .preparing, .pickingUp, .onTheWay, .delivered]
    }
}
