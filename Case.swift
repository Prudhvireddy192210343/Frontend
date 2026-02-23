import Foundation

// MARK: - Case Model
struct Case: Identifiable, Codable {
    let id: String
    var patientName: String
    var patientId: String
    var patientImageUrl: String?
    var chiefComplaint: String
    var complaintType: ComplaintType
    var additionalDetails: String
    var medicalHistory: String
    var status: CaseStatus
    var createdDate: Date
    var lastUpdated: Date
    var doctorId: String
    var doctorName: String
    
    enum ComplaintType: String, Codable, CaseIterable {
        case pain = "Pain"
        case wornTeeth = "Worn Teeth"
        case poorEsthetics = "Poor Esthetics"
        case difficultyChewing = "Difficulty Chewing"
        
        var icon: String {
            switch self {
            case .pain: return "Pain"
            case .wornTeeth: return "Worn Teeth"
            case .poorEsthetics: return "Poor Esthetics"
            case .difficultyChewing: return "Difficulty Chewing"
            }
        }
    }
    
    enum CaseStatus: String, Codable {
        case active = "Active"
        case pending = "Pending Approval"
        case completed = "Completed"
        case archived = "Archived"
        
        var color: String {
            switch self {
            case .active: return "#07883b" // green
            case .pending: return "#f59e0b" // amber
            case .completed: return "#3b82f6" // blue
            case .archived: return "#6b7280" // gray
            }
        }
    }
}

// MARK: - Sample Data
extension Case {
    static let sampleCases: [Case] = [
        Case(
            id: "2024001",
            patientName: "Mahi",
            patientId: "2024001",
            patientImageUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop",
            chiefComplaint: "Chief Complaint: Toothache",
            complaintType: .pain,
            additionalDetails: "Sharp pain in lower right molar, sensitivity to cold",
            medicalHistory: "No known allergies",
            status: .active,
            createdDate: Date().addingTimeInterval(-86400 * 5),
            lastUpdated: Date().addingTimeInterval(-3600),
            doctorId: "DR001",
            doctorName: "Dr. Tanu"
        ),
        Case(
            id: "2024002",
            patientName: "Prudhvi",
            patientId: "2024002",
            patientImageUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop",
            chiefComplaint: "Chief Complaint: Missing tooth",
            complaintType: .poorEsthetics,
            additionalDetails: "Missing upper front tooth after accident",
            medicalHistory: "Diabetic",
            status: .active,
            createdDate: Date().addingTimeInterval(-86400 * 3),
            lastUpdated: Date().addingTimeInterval(-7200),
            doctorId: "DR001",
            doctorName: "Dr. Tanu"
        ),
        Case(
            id: "2024003",
            patientName: "Raju",
            patientId: "2024003",
            patientImageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop",
            chiefComplaint: "Chief Complaint: Discomfort",
            complaintType: .difficultyChewing,
            additionalDetails: "Difficulty chewing on left side",
            medicalHistory: "None",
            status: .pending,
            createdDate: Date().addingTimeInterval(-86400 * 2),
            lastUpdated: Date().addingTimeInterval(-1800),
            doctorId: "DR001",
            doctorName: "Dr. Tanu"
        )
    ]
}

// MARK: - Case Repository
class CaseRepository: ObservableObject {
    static let shared = CaseRepository()
    
    private let casesKey = "fmr_persistent_cases"
    
    @Published var cases: [Case] = []
    
    // Draft case for new submission flow
    @Published var draftPatientName: String = ""
    @Published var draftPatientAge: String = ""
    @Published var draftPatientGender: String = "Male"
    @Published var draftChiefComplaint: String = ""
    @Published var draftAdditionalDetails: String = ""
    
    private init() {
        loadCases()
    }
    
    func saveCases() {
        if let encoded = try? JSONEncoder().encode(cases) {
            UserDefaults.standard.set(encoded, forKey: casesKey)
        }
    }
    
    func loadCases() {
        if let data = UserDefaults.standard.data(forKey: casesKey),
           let decoded = try? JSONDecoder().decode([Case].self, from: data) {
            self.cases = decoded
        } else {
            // Load defaults if nothing saved
            self.cases = Case.sampleCases
            saveCases()
        }
    }
    
    func addCase(fromDraft: Bool = true) {
        let gender = draftPatientGender.isEmpty ? "Male" : draftPatientGender
        let imageUrl = getImageUrl(for: gender)
        
        let newCase = Case(
            id: String(Int.random(in: 1000...9999)),
            patientName: draftPatientName.isEmpty ? "New Patient" : draftPatientName,
            patientId: String(Int.random(in: 2024004...2025000)),
            patientImageUrl: imageUrl,
            chiefComplaint: draftChiefComplaint.isEmpty ? "Chief Complaint: Evaluation" : "Chief Complaint: \(draftChiefComplaint)",
            complaintType: .poorEsthetics, 
            additionalDetails: draftAdditionalDetails,
            medicalHistory: "Age: \(draftPatientAge), Gender: \(draftPatientGender)",
            status: .active,
            createdDate: Date(),
            lastUpdated: Date(),
            doctorId: "DR001",
            doctorName: "Dr. Tanu"
        )
        
        cases.insert(newCase, at: 0)
        saveCases() // Persist
        
        // Reset draft
        draftPatientName = ""
        draftPatientAge = ""
        draftPatientGender = "Male"
        draftChiefComplaint = ""
        draftAdditionalDetails = ""
    }
    
    func getImageUrl(for gender: String) -> String {
        if gender.lowercased() == "female" {
            return [
                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop",
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop",
                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&h=200&fit=crop"
            ].randomElement()!
        } else {
            return [
                "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&h=200&fit=crop",
                "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop",
                "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?w=200&h=200&fit=crop",
                "https://images.unsplash.com/photo-1552058544-f2b08422138a?w=200&h=200&fit=crop"
            ].randomElement()!
        }
    }
    
    func deleteCase(at offsets: IndexSet) {
        cases.remove(atOffsets: offsets)
        saveCases()
    }
    
    func deleteCase(id: String) {
        cases.removeAll { $0.id == id }
        saveCases()
    }
    
    // Statistics
    var activeCount: Int { cases.filter { $0.status == .active }.count }
    var pendingCount: Int { cases.filter { $0.status == .pending }.count }
    var completedCount: Int { cases.filter { $0.status == .completed }.count }
}
