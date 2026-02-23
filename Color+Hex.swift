import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }

    // MARK: - Semantic Adaptive Colors
    
    static var appPrimaryText: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : UIColor(red: 13/255, green: 18/255, blue: 27/255, alpha: 1)
        })
    }
    
    static var appSecondaryText: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.lightGray : UIColor(red: 76/255, green: 102/255, blue: 154/255, alpha: 1)
        })
    }
    
    static var appBackground: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 13/255, green: 18/255, blue: 27/255, alpha: 1) : UIColor(red: 248/255, green: 249/255, blue: 252/255, alpha: 1)
        })
    }
    
    static var appCardBackground: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 25/255, green: 32/255, blue: 45/255, alpha: 1) : .white
        })
    }
    
    static var appBorder: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.darkGray : UIColor(red: 207/255, green: 215/255, blue: 231/255, alpha: 1)
        })
    }
}
