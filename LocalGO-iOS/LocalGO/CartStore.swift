import Foundation
import Combine

final class CartStore: ObservableObject {
    @Published var items: [String: Int] = [:]           // menuItemId -> quantity
    @Published var restaurant: Restaurant? = nil
    @Published var menuItemsMap: [String: MenuItem] = [:]  // menuItemId -> MenuItem snapshot

    // MARK: - Add
    func add(_ item: MenuItem, from rest: Restaurant) {
        if let current = restaurant, current.id != rest.id {
            // Different restaurant — clear cart first
            items = [:]
            menuItemsMap = [:]
        }
        restaurant = rest
        menuItemsMap[item.id] = item
        items[item.id, default: 0] += 1
    }

    // MARK: - Remove
    func remove(_ item: MenuItem) {
        guard let qty = items[item.id] else { return }
        if qty <= 1 {
            items.removeValue(forKey: item.id)
            menuItemsMap.removeValue(forKey: item.id)
        } else {
            items[item.id] = qty - 1
        }
        if items.isEmpty {
            restaurant = nil
        }
    }

    // MARK: - Clear
    func clear() {
        items = [:]
        menuItemsMap = [:]
        restaurant = nil
    }

    // MARK: - Computed
    var totalCount: Int {
        items.values.reduce(0, +)
    }

    var totalPrice: Double {
        items.reduce(0.0) { sum, entry in
            let price = menuItemsMap[entry.key]?.price ?? 0
            return sum + price * Double(entry.value)
        }
    }

    // Ordered list of cart items for display
    var cartLines: [(item: MenuItem, qty: Int)] {
        menuItemsMap.compactMap { (id, item) in
            guard let qty = items[id], qty > 0 else { return nil }
            return (item: item, qty: qty)
        }
        .sorted { $0.item.name < $1.item.name }
    }
}
