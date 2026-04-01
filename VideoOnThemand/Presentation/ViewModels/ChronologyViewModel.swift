//
//  ChronologyViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 26/08/25.
//

import Foundation
import ElechimCore

@MainActor
class ChronologyViewModel: ObservableObject {
    @Published var chronologyList: [Chronology] = []
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
    @Published var isLoading: Bool = false
    
    private let fetchChronologyUseCase: FetchChronologyUseCase
    private let sessionManager: SessionManager
    
    init(fetchChronologyUseCase: FetchChronologyUseCase,
         sessionManager: SessionManager) {
     
        self.fetchChronologyUseCase = fetchChronologyUseCase
        self.sessionManager = sessionManager
    }
    
    func loadChronology() async {
        isLoading = true
        do {
            let stream = try await fetchChronologyUseCase.execute(localUser: sessionManager.currentUser?.id ?? "")
            for await listChronology in stream {
                isLoading = false
                chronologyList = listChronology.sorted(by: { $0.date > $1.date })
            }
        } catch  {
            Utils.showError(alertMessage: &alertMessage, showAlert: &showAlert, from: error)
        }
    }
}
