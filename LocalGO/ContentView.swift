import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)

            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: selectedTab == 1 ? "receipt.fill" : "receipt")
                }
                .tag(1)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 2 ? "person.fill" : "person")
                }
                .tag(2)
        }
        .tint(Color.brand)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor(Color.navyDeep)
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.muted)
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.muted)]
            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.brand)
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.brand)]
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CartStore())
}
