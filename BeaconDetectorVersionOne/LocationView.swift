//
//  LocationView.swift
//  BeaconDetectorVersionOne
//
//  Created by TESTING on 22/01/2020.
//  Copyright © 2020 TESTING. All rights reserved.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        Image("FPV")
        .resizable()
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
