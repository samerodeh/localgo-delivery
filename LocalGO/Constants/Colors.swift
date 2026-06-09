import SwiftUI

extension Color {
    // Brand
    static let brand        = Color(hex: "#f97316")  // orange
    static let brandLight   = Color(hex: "#fb923c")
    static let brandDark    = Color(hex: "#ea580c")
    static let brandDim     = Color(hex: "#f97316").opacity(0.15)

    // Navy
    static let navyDeep     = Color(hex: "#020617")
    static let navy         = Color(hex: "#0f172a")
    static let navyMid      = Color(hex: "#1e293b")
    static let navyLight    = Color(hex: "#334155")

    // Neutrals
    static let appBackground = Color(hex: "#f8fafc")
    static let surface      = Color.white
    static let border       = Color(hex: "#e2e8f0")
    static let smoke        = Color(hex: "#e2e8f0")
    static let muted        = Color(hex: "#94a3b8")
    static let textPrimary  = Color(hex: "#0f172a")
    static let textSecondary = Color(hex: "#64748b")
    static let gray100      = Color(hex: "#f1f5f9")
    static let gray200      = Color(hex: "#e2e8f0")
    static let gray300      = Color(hex: "#cbd5e1")

    // Semantic
    static let success      = Color(hex: "#10b981")
    static let appError     = Color(hex: "#ef4444")
    static let warning      = Color(hex: "#f59e0b")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}

// MARK: - Shadow helper
extension View {
    func cardShadow() -> some View {
        self.shadow(color: Color.navy.opacity(0.07), radius: 8, x: 0, y: 2)
    }

    func subtleShadow() -> some View {
        self.shadow(color: Color.navy.opacity(0.05), radius: 6, x: 0, y: 1)
    }
}
