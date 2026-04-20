//
//  ContentView.swift
//  HealthTrackerTM
//
//  Created by Tatiana6mo on 4/14/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel: HealthViewModel = HealthViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    HeaderSectionView()
                    StepCardView(steps: viewModel.steps)
                    DistanceCardView(distance: viewModel.distance)
                    ActivityStatusCard(activityStatus: viewModel.activityStatus, authStatus: viewModel.authStatus,
                                       isAuthorized:viewModel.isAuthorized)
                    
                    Spacer()
                }
                .padding()
            }.navigationTitle(Text("Health Tracker"))
                .onAppear{
                    viewModel.requestAuth()
                }
                .refreshable{
                    viewModel.fetchTodaySteps()
                    viewModel.fetchTodayDistance()
                }
        }
    }
}

#Preview {
    ContentView()
}
