import SwiftUI

// MARK: - Cases List View
struct CasesListView: View {
    @State private var searchText = ""
    @State private var selectedFilter: CaseFilter = .all
    @ObservedObject private var repository = CaseRepository.shared
    
    var cases: [Case] {
        repository.cases
    }
    
    enum CaseFilter: String, CaseIterable {
        case all = "All"
        case active = "Active"
        case pending = "Pending"
        case completed = "Completed"
    }
    
    var filteredCases: [Case] {
        var result = cases
        
        // Filter by status
        switch selectedFilter {
        case .all:
            break
        case .active:
            result = result.filter { $0.status == .active }
        case .pending:
            result = result.filter { $0.status == .pending }
        case .completed:
            result = result.filter { $0.status == .completed }
        }
        
        // Search filter
        if !searchText.isEmpty {
            result = result.filter {
                $0.patientName.localizedCaseInsensitiveContains(searchText) ||
                $0.patientId.localizedCaseInsensitiveContains(searchText) ||
                $0.chiefComplaint.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Bar
            HStack {
                Text("Cases")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.appPrimaryText)
                
                Spacer()
                
                // Add new case button
                NavigationLink(destination: ChiefComplaintView()) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(Color.blue)
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            // MARK: - Search Bar
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.appSecondaryText)
                
                TextField("Search cases...", text: $searchText)
                    .font(.system(size: 16))
                    .foregroundColor(.appPrimaryText)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.appSecondaryText)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            // MARK: - Filter Tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(CaseFilter.allCases, id: \.self) { filter in
                        FilterChip(
                            title: filter.rawValue,
                            count: getCaseCount(for: filter),
                            isSelected: selectedFilter == filter
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedFilter = filter
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
            
            Divider()
                .background(Color.appBorder)
            
            // MARK: - Cases List
            if filteredCases.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "folder")
                        .font(.system(size: 64))
                        .foregroundColor(.appBorder)
                    
                    Text("No cases found")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.appSecondaryText)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 60)
            } else {
                List {
                    ForEach(filteredCases) { caseItem in
                        NavigationLink(destination: CaseDetailView(caseItem: caseItem)) {
                            CaseListRow(caseItem: caseItem)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.appCardBackground)
                        .listRowSeparatorTint(Color.appBorder.opacity(0.5))
                        .buttonStyle(.plain)
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
                .background(Color.appBackground)
            }
        }
        .background(Color.appBackground)
        .navigationBarHidden(true)
    }
    
    private func delete(at offsets: IndexSet) {
        // Need to find the correct IDs because filteredCases might have different indices
        offsets.forEach { index in
            let caseToDelete = filteredCases[index]
            repository.deleteCase(id: caseToDelete.id)
        }
    }
    
    private func getCaseCount(for filter: CaseFilter) -> Int {
        switch filter {
        case .all:
            return cases.count
        case .active:
            return cases.filter { $0.status == .active }.count
        case .pending:
            return cases.filter { $0.status == .pending }.count
        case .completed:
            return cases.filter { $0.status == .completed }.count
        }
    }
}

// MARK: - Components
private struct FilterChip: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                
                Text("\(count)")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(isSelected ? Color.white.opacity(0.3) : Color.appBorder)
                    )
            }
            .foregroundColor(isSelected ? .white : .appSecondaryText)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.blue : Color.clear)
            )
            .overlay(
                Capsule()
                    .stroke(Color.appBorder, lineWidth: isSelected ? 0 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct CaseListRow: View {
    let caseItem: Case
    
    var statusColor: Color {
        switch caseItem.status {
        case .active:
            return Color(red: 7/255, green: 136/255, blue: 59/255)
        case .pending:
            return Color(red: 245/255, green: 158/255, blue: 11/255)
        case .completed:
            return Color.blue
        case .archived:
            return Color.gray
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Patient Avatar
            if let imageUrl = caseItem.patientImageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .overlay(
                            Text(String(caseItem.patientName.prefix(1)))
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                        )
                }
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            } else {
                // Fallback: Initial circle
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Text(String(caseItem.patientName.prefix(1)))
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.blue)
                    )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(caseItem.patientName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.appPrimaryText)
                    
                    Text(caseItem.status.rawValue)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(statusColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(
                            Capsule()
                                .fill(statusColor.opacity(0.1))
                        )
                }
                
                Text(caseItem.chiefComplaint)
                    .font(.system(size: 14))
                    .foregroundColor(.appSecondaryText)
                
                Text("ID: \(caseItem.patientId) • \(timeAgo(from: caseItem.lastUpdated))")
                    .font(.system(size: 13))
                    .foregroundColor(.appSecondaryText.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.appBorder)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.appCardBackground)
    }
    
    private func timeAgo(from date: Date) -> String {
        let interval = Date().timeIntervalSince(date)
        let hours = Int(interval / 3600)
        
        if hours < 1 {
            return "Just now"
        } else if hours < 24 {
            return "\(hours)h ago"
        } else {
            let days = hours / 24
            return "\(days)d ago"
        }
    }
}

#Preview {
    NavigationStack {
        CasesListView()
    }
}
