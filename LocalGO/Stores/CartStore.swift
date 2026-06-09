import SwiftUI
import Combine

struct CartEntry: Identifiable {
    let id: String
    let item: MenuItem
    let restaurantName: String
    var qty: Int
}

@MainActor
final class CartStore: ObservableObject {
    @Published private(set) var entries: [CartEntry] = []
    @Published private(set) var restaurantName: String = ""

    var totalCount: Int { entries.reduce(0) { $0 + $1.qty } }

    var subtotal: Double {
        entries.reduce(0) { $0 + $1.item.price * Double($1.qty) }
    }

    let deliveryFee: Double = 1.99
    let serviceFee: Double = 0.99
    var total: Double { subtotal + deliveryFee + serviceFee }

    func add(_ item: MenuItem, from restaurant: Restaurant) {
        if restaurantName != restaurant.name && !entries.isEmpty {
            // Different restaurant — clear cart first
            entries = []
        }
        restaurantName = restaurant.name

        if let idx = entries.firstIndex(where: { $0.id == item.id }) {
            entries[idx].qty += 1
        } else {
            entries.append(CartEntry(id: item.id, item: item, restaurantName: restaurant.name, qty: 1))
        }
    }

    func remove(_ item: MenuItem) {
        guard let idx = entries.firstIndex(where: { $0.id == item.id }) else { return }
        if entries[idx].qty > 1 {
            entries[idx].qty -= 1
        } else {
            entries.remove(at: idx)
            if entries.isEmpty { restaurantName = "" }
        }
    }

    func qty(for itemId: String) -> Int {
        entries.first(where: { $0.id == itemId })?.qty ?? 0
    }

    func clear() {
        entries = []
        restaurantName = ""
    }
}
