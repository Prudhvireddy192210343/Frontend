import SwiftUI

// MARK: - Insights View (matches your HTML UI)
struct InsightsView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: - Top Bar
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.appPrimaryText)
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle())
                        }

                        Text("Insights")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.appPrimaryText)
                            .frame(maxWidth: .infinity, alignment: .center)

                        // Spacer to mimic "pr-12"
                        Color.clear
                            .frame(width: 44, height: 44)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    .padding(.bottom, 8)
                    .background(Color.appCardBackground)

                    // MARK: - Monthly Practice Overview Card
                    HStack(alignment: .top, spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Monthly Practice Overview")
                                .font(.system(size: 14))
                                .foregroundColor(.appSecondaryText)

                            Text("Cases Processed")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.appPrimaryText)

                            Text("24")
                                .font(.system(size: 14))
                                .foregroundColor(.appSecondaryText)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuAShN9cxSSadiqvyMczMsn9mvPmxESEmWJ4jilnXduGJEMjFRdBwGiXgj0h6WW7KujgDmwKu9LZdJHRHvjkXAk4K5fnuXzcuxv0XoCJ8P2vDsjdWWJDwf9VY7g9hhiaxQT01irLCB077NkAq5OtjFFUluwUN9bDuOhXhpEeZ9Q8abNGniY00xrlA-IsPSpbHsjgrdus5x0LnwE2l2yeSoixWUd6Pu1g-m7FCxbwB-awV-W2IjPCE3DmsvNnbSNdiniMUgc5StEsmR4")) { img in
                            img.resizable().scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.15)
                        }
                        .frame(width: 160, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(16)
                    .background(Color.appCardBackground)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    // MARK: - Stat Cards
                    HStack(spacing: 12) {
                        InsightStatCard(title: "Avg. Treatment Success", value: "98%")
                        InsightStatCard(title: "Clinical Efficiency", value: "+15%")
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                    // MARK: - Case Success Rates
                    Text("Case Success Rates")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 8)

                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .bottom, spacing: 18) {
                            BarItem(heightPercent: 0.60, label: "Full Rehabilitation")
                            BarItem(heightPercent: 0.60, label: "Orthodontics")
                            BarItem(heightPercent: 0.70, label: "Implants")
                        }
                        .frame(minHeight: 180)
                        .padding(.horizontal, 6)
                    }
                    .padding(16)
                    .background(Color.appCardBackground)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    // MARK: - Top Findings
                    Text("Top Findings")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 8)

                    InsightRow(icon: "flag", title: "Bruxism detected", subtitle: "40% of cases")
                        .padding(.horizontal, 16)

                    // MARK: - Predictive Trends
                    Text("Predictive Trends")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 8)

                    Text("AI-generated forecast of upcoming high-complexity cases.")
                        .font(.system(size: 15))
                        .foregroundColor(.appSecondaryText)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 30)
                }
            }

        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

// MARK: - Small Components

private struct InsightStatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.appSecondaryText)

            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.appPrimaryText)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 92, alignment: .leading)
        .background(Color.appCardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}

private struct BarItem: View {
    let heightPercent: CGFloat   // 0.0 - 1.0
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.blue.opacity(0.15))
                .overlay(
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 3),
                    alignment: .top
                )
                .frame(width: 70)
                .frame(height: 180 * heightPercent)

            Text(label)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.appSecondaryText)
                .multilineTextAlignment(.center)
                .frame(width: 80)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

private struct InsightRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.blue)
            }
            .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.appPrimaryText)
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.appSecondaryText)
            }

            Spacer()
        }
        .padding(16)
        .background(Color.appCardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}


#Preview {
    NavigationStack {
        InsightsView()
    }
}
