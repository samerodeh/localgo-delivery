import SwiftUI

@main
struct LocalGOApp: App {
    @StateObject private var cartStore = CartStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartStore)
                .preferredColorScheme(.light)
        }
    }
}
