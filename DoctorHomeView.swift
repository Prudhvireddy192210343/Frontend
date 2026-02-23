import SwiftUI

// MARK: - Doctor Home / Dashboard
struct DoctorHomeView: View {
    @State private var showNotifications = false

    var body: some View {
        VStack(spacing: 0) {

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: - Top Bar
                    HStack {

                        // Avatar → DoctorProfileView
                        NavigationLink(destination: DoctorProfileView()) {
                            AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuBbkAAQjR7W94fU8WRtGzOiOtstRqX7sCY2-CQsAhRtBb2-crhl_8wt8deMRf4k_bNaURu-KjhCgQYHomzS38iAmDV72Y_RxDD6RxfZvO1rRVs1CrrFzOwqAesJ6ZsGqog3aE9rf7fWANDiUqAssOFnF7IqwpZ90kljMQDvi0Rqzoqdvwkyvhib-5O_bc3e6W7FQy0DWMGICDLvACIuGnGk7wYg28KAxMYvVZ2-mQGja_DZgOqLcnH6vMwihRs7syVHYRfc1QvfS00")) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.2)
                            }
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                        }
                        .buttonStyle(.plain)

                        Spacer()

                        Button {
                            showNotifications = true
                        } label: {
                            Image(systemName: "bell")
                                .font(.system(size: 22, weight: .regular))
                                .foregroundColor(.appPrimaryText)
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .background(
                            NavigationLink(destination: NotificationsView(), isActive: $showNotifications) {
                                EmptyView()
                            }
                            .hidden()
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 6)

                    // MARK: - Title
                    Text("Welcome back, Dr. Tanu")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        .padding(.bottom, 10)

                    // MARK: - Start New Patient Case Card
                    NavigationLink(destination: ChiefComplaintView()) {
                        HStack(alignment: .top, spacing: 14) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Start New Patient Case")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.appSecondaryText)

                                Text("Add a new patient case")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appPrimaryText)

                                Text("Begin a new treatment plan")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.appSecondaryText)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuDV-sWTIx0OOM2-BUuWhd28HO6hJSFSjWmEFCatdeD-S_vhO4_-4ER2RTqYi57zpsfHnwB4ceognPpS9o8_sVNb_RpF0tPFqVNTvb_SI1hDFGBEbytSzWEkOW4PfKfqWeU6YKOJ3iu5WYmCxf_73bttB-5XluNRqDjpbJciq8gf4MfiA7R3wu3gYTOZ2H2pKnssS2OEM25rQtZUUME7UdiYy2WAroCkPZyxXmyMRQu7ikHExWKIzN-JJ2q12tOiKh5hmXI08IxdMls")) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.15)
                            }
                            .frame(width: 160, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .padding(16)
                        .background(Color.appCardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)


                    // MARK: - Case Statistics
                    Text("Case Statistics")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 8)

                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            StatCard(title: "Active Plans", value: "\(CaseRepository.shared.activeCount)")
                            StatCard(title: "Pending Approval", value: "\(CaseRepository.shared.pendingCount)")
                        }
                        HStack(spacing: 12) {
                            StatCard(title: "Completed", value: "\(CaseRepository.shared.completedCount)")
                            Spacer(minLength: 0)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)

                    // MARK: - Recent Patient Cases
                    Text("Recent Patient Cases")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.appPrimaryText)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        .padding(.bottom, 8)

                    ForEach(CaseRepository.shared.cases) { caseItem in
                        NavigationLink(destination: CaseDetailView(caseItem: caseItem)) {
                            RecentCaseRow(name: caseItem.patientName,
                                          complaint: caseItem.chiefComplaint,
                                          idText: "ID: \(caseItem.patientId)",
                                          isActive: caseItem.status == .active)
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer(minLength: 12)
                }
                .padding(.bottom, 10)
            }

        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
}

// MARK: - Components

private struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appPrimaryText)

            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.appPrimaryText)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .leading)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}

private struct RecentCaseRow: View {
    let name: String
    let complaint: String
    let idText: String
    let isActive: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.appPrimaryText)

                Text(complaint)
                    .font(.system(size: 14))
                    .foregroundColor(.appSecondaryText)

                Text(idText)
                    .font(.system(size: 14))
                    .foregroundColor(.appSecondaryText)
            }

            Spacer()

            Circle()
                .fill(isActive ? Color(red: 7/255, green: 136/255, blue: 59/255) : Color.gray.opacity(0.4))
                .frame(width: 10, height: 10)
                .padding(.trailing, 6)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.appCardBackground)
        .overlay(
            Rectangle()
                .fill(Color.appBorder.opacity(0.5))
                .frame(height: 1),
            alignment: .bottom
        )
    }
}


#Preview {
    NavigationStack {
        DoctorHomeView()
    }
}
