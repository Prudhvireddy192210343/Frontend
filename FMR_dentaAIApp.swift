import SwiftUI

@main
struct FMR_dentaAIApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("selectedLanguageCode") private var selectedLanguageCode = "en"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, .init(identifier: selectedLanguageCode))
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
