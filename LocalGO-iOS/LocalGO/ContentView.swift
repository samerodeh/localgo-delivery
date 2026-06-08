import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var cartStore: CartStore

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "bag.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(.brandOrange)
    }
}

#Preview {
    ContentView()
        .environmentObject(CartStore())
}
