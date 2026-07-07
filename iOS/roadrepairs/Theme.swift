import SwiftUI

/// garage-floor charcoal with a warning-light rust-red accent
enum Theme {
    static let background = Color(red: 0.102, green: 0.075, blue: 0.063)
    static let accent = Color(red: 0.82, green: 0.294, blue: 0.18)
    static let ink = Color(red: 0.969, green: 0.925, blue: 0.902)
    static let cardBackground = Color(red: 0.173, green: 0.145, blue: 0.133)
    static let secondaryInk = Color(red: 0.812, green: 0.769, blue: 0.745)

    static let titleFont = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let headingFont = Font.system(.headline, design: .rounded).weight(.semibold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 18
}

extension View {
    func themedBackground() -> some View {
        self.background(Theme.background.ignoresSafeArea())
    }
}
