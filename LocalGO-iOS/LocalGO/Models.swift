import Foundation

// MARK: - RestaurantCategory
struct RestaurantCategory: Identifiable, Hashable {
    let id: String
    let label: String
    let icon: String
}

// MARK: - RestaurantBadge
enum RestaurantBadge: String {
    case popular = "Popular"
    case new     = "New"
    case deal    = "Deal"
}

// MARK: - MenuItem
struct MenuItem: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let image: String
    var popular: Bool = false
    var section: String? = nil
}

// MARK: - Restaurant
struct Restaurant: Identifiable, Hashable {
    let id: String
    let name: String
    let category: String
    let image: String
    let rating: Double
    let reviewCount: Int
    let deliveryTime: String
    let deliveryFee: Double
    let minOrder: Double
    let distance: String
    var badge: RestaurantBadge? = nil
    let tags: [String]
    let address: String
    let menu: [MenuItem]
}

// MARK: - OrderStatus
enum OrderStatus: Int, CaseIterable {
    case placing   = 0
    case preparing = 1
    case pickingUp = 2
    case onTheWay  = 3
    case delivered = 4
    case cancelled = 5

    var label: String {
        switch self {
        case .placing:   return "Placing"
        case .preparing: return "Preparing"
        case .pickingUp: return "Picking Up"
        case .onTheWay:  return "On the Way"
        case .delivered: return "Delivered"
        case .cancelled: return "Cancelled"
        }
    }
}

// MARK: - OrderItem
struct OrderItem: Identifiable {
    let id: UUID = UUID()
    let name: String
    let qty: Int
    let price: Double
}

// MARK: - Order
struct Order: Identifiable {
    let id: String
    let restaurantName: String
    let restaurantImage: String
    let status: OrderStatus
    let items: [OrderItem]
    let total: Double
    let date: String
    let deliveryAddress: String
    var estimatedTime: String? = nil
}
