import SwiftUI

struct CategoryChipView: View {
    let label: String
    let icon: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isActive ? .white : Color.textSecondary)
                Text(label)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isActive ? .white : Color.textSecondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isActive ? Color.brand : Color.surface)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isActive ? Color.brand : Color.border, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        CategoryChipView(label: "All", icon: "square.grid.2x2.fill", isActive: true) {}
        CategoryChipView(label: "Burgers", icon: "fork.knife", isActive: false) {}
    }
    .padding()
}
