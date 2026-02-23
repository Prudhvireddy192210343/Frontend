import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                DoctorHomeView()
            }
            .tabItem {
                Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
            }
            .tag(0)
            
            NavigationStack {
                CasesListView()
            }
            .tabItem {
                Label("Cases", systemImage: selectedTab == 1 ? "briefcase.fill" : "briefcase")
            }
            .tag(1)
            
            NavigationStack {
                InsightsView()
            }
            .tabItem {
                Label("Insights", systemImage: selectedTab == 2 ? "chart.bar.fill" : "chart.bar")
            }
            .tag(2)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: selectedTab == 3 ? "gearshape.fill" : "gearshape")
            }
            .tag(3)
        }
        .accentColor(.blue)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
}
