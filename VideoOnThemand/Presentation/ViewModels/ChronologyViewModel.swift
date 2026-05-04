//
//  ChronologyViewModel.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 26/08/25.
//

import Foundation
import ElechimCore
import Services

@MainActor
class ChronologyViewModel: ObservableObject {
    @Published var chronologyList: [Chronology] = []
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
    @Published var isLoading: Bool = false
    
    private let fetchChronologyUseCase: FetchChronologyUseCase
    private let sessionManager: SessionManager
    private var fetchCronologyTask: Task<Void,Never>?
    
    init(fetchChronologyUseCase: FetchChronologyUseCase,
         sessionManager: SessionManager) {
     
        self.fetchChronologyUseCase = fetchChronologyUseCase
        self.sessionManager = sessionManager
    }
    
    func start() {
       fetchCronologyTask = Task {
          await  self.loadChronology()
        }
    }
    
   private func stopAndClear() {
        CustomLog.debug(category: .VM, "Stopping Firestore stream...")
        self.fetchCronologyTask?.cancel()
        self.fetchCronologyTask = nil
    }
    
    func loadChronology() async {
        CustomLog.debug(category: .VM, "\(#function)")
        isLoading = true
        do {
            let stream = await fetchChronologyUseCase.execute(localUser: sessionManager.currentUser?.id ?? "")
            for try await listChronology in stream {
                if Task.isCancelled {
                    break
                }
                isLoading = false
                chronologyList = listChronology.sorted(by: { $0.date > $1.date })
            }
        } catch  {
            Utils.showError(alertMessage: &alertMessage, showAlert: &showAlert, from: error)
        }
    }
    
    func showError(error: any Error) {
        CustomLog.debug(category: .VM, "\(error.localizedDescription)")
        Utils.showError(alertMessage: &alertMessage, showAlert: &showAlert, from: error)
    }
    
    func clearData() {
        // 1. stop tasks
        self.stopAndClear()
        // 2. clear all variables
        self.chronologyList = []
        self.showAlert = false
        self.alertMessage = ""
        self.isLoading = false
    }
}
