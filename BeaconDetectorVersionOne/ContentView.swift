//
//  ContentView.swift
//  BeaconDetectorVersionOne
//
//  Created by TESTING on 22/01/2020.
//  Copyright © 2020 TESTING. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)

            LocationView()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            BeaconDetectorView()

            VStack(alignment: .leading) {
                Text("Fakulta Prírodnych Vied")
                    .font(.title)
                HStack(alignment: .top) {
                    Text("Katedra Informatiky")
                        .font(.subheadline)
                    Spacer()
                    Text("Banská Bystrica")
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
            
        }
    }
}
