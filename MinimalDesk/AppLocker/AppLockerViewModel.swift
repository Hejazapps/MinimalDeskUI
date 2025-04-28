//
//  AppLockerViewModel.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 20/10/24.
//

import Combine
import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings

class AppLockerViewModel: ObservableObject {
    private let activitySelectionKey = "ScreenTimeSelection"
    private let appLockStatusKey = "AppLockStatus"
    
    let userDefaults = UserDefaults(suiteName: "group.wasim.minimaldesk")
    var cancellable: AnyCancellable?
    
    @Published var activitySelection = FamilyActivitySelection()
    @Published var selectedTokens = [SelectionType]()
    var appLockStatus = false
    
    static let shared = AppLockerViewModel()
    
    private init() {
        loadSavedSelectionAndAppLockStatus()
        
//        cancellable = $activitySelection.sink { [weak self] _ in
//            self?.saveSelection()
//        }
    }
    
    // MARK: - Public APIs
    func requestAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            }
            catch {
                log("Authorization failed.")
            }
        }
    }
    
    func saveSelection() {
        createSelectedTokens()
        userDefaults?.set(try? PropertyListEncoder().encode(activitySelection), forKey: activitySelectionKey)
    }
    
    func toggleAppRestriction(lock: Bool) {
        let store = ManagedSettingsStore(named: .init("MinimalDesk.AppLocker.Store"))
        
        store.shield.applications?.removeAll()
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
        
        if lock {
            store.shield.applications = activitySelection.applicationTokens
            store.shield.applicationCategories = .specific(activitySelection.categoryTokens)
        }
        
        appLockStatus = lock
        userDefaults?.set(lock, forKey: appLockStatusKey)
    }
}

// MARK: - Private Helper Methods
private extension AppLockerViewModel {
    func loadSavedSelectionAndAppLockStatus() {
        guard let data = userDefaults?.data(forKey: activitySelectionKey) else { return }
        
        guard let activitySelection = try? PropertyListDecoder().decode(FamilyActivitySelection.self, from: data) else {
            return
        }
        
        self.activitySelection = activitySelection
        createSelectedTokens()
        
        guard let appLockStatus = userDefaults?.value(forKey: appLockStatusKey) as? Bool else { return }
        self.appLockStatus = appLockStatus
    }
    
    func createSelectedTokens() {
        selectedTokens = []
        activitySelection.applicationTokens.forEach { selectedTokens.append(.application($0)) }
        activitySelection.categoryTokens.forEach { selectedTokens.append(.category($0)) }
    }
}

extension AppLockerViewModel {
    enum SelectionType: Hashable {
        case application(ApplicationToken)
        case category(ActivityCategoryToken)
    }
}
