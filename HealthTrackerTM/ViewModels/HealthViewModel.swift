//
//  HealthViewModel.swift
//  HealthTrackerTM
//
//  Created by Tatiana6mo on 4/14/26.
//

import Foundation
import Combine
import HealthKit

class HealthViewModel: ObservableObject {
    
    @Published var steps: Int = 0
    @Published var distance: Double = 0.0
    @Published var activityStatus: String = "Sometimes Active"
    @Published var authStatus: String = "Not Requested"
    @Published var isAuthorized: Bool = false
    
    //
    private let healthStore: HKHealthStore = HKHealthStore()
    init(){
        checkHealthDataAvailability()
    }
    
    private func checkHealthDataAvailability(){
        if HKHealthStore.isHealthDataAvailable() {
            print("Is available on this device")
        }else {
            print("Not Available on this device")
            authStatus = "Not Available"
        }
    }
    
    func requestAuth(){
        // Define the types of data we want to read
        let typeToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!, //! <-- I am sure I will use this data
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
            
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typeToRead) { success, error in
            DispatchQueue.main.async {
               
                if success {
                    self.isAuthorized = true
                    self.authStatus = "Authorized"
                    
                    self.fetchTodaySteps()
                    self.fetchTodayDistance()
                }else {
                    
                    self.isAuthorized = false
                    self.authStatus = "Not Authorized"
                    
                    if let error = error {
                        print("HealthKit authorization request failed with error: \(error.localizedDescription)")
                    }
                }
                
                
            }
        }
        // end of func
    }
    
    func fetchTodaySteps(){
        guard let stepCountTpye = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("No Steps")
            return
            
        }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        // Predicate = Samples
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now,options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCountTpye, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("refeash app")
                    self.distance = 0.0
                    return
                }
                
                // Complex if statement
                if let result = result, let sum = result.sumQuantity(){
                    let steps = Int(sum.doubleValue(for: .count()))
                    self.steps = steps
                    self.updateActivityStatus()
                
                }else {
                    self.steps = 0
                    self.updateActivityStatus()
                    
                    
             }
        }
            
        
    }
        
        healthStore.execute(query)
        
    }
    
    func fetchTodayDistance(){
        guard let stepCountTpye = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("No distance")
            return
            
        }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        // Predicate = Samples
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now,options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("refeash app")
                    self.distance = 0.0
                    return
                }
                
                // Complex if statement
                if let result = result, let sum = result.sumQuantity(){
                    let distanceInMeter = sum.doubleValue(for: .meter())
                    let distanceInKm = distanceInMeter / 1000.0
                    self.distance = distanceInKm
                    
                    
                }else {
                    self.distance = 0.0
                    
                    
                    
                }
            }
            
            
        }
        
        healthStore.execute(query)
        
    }
    
    // func startObservingSteps
        
        //MARK: Own Logic
        private func updateActivityStatus() {
            
            if steps < 2000 {
                activityStatus = "Getting Started"
            }else if steps < 5000 {
                activityStatus = "Let get it"
            }else if steps < 70000 {
                activityStatus = "Almost there"
            }else if steps > 10000{
                activityStatus = "You made it!"
                
            }
            
            
        }
        
    }

