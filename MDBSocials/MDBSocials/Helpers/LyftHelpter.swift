//
//  LyftHelpter.swift
//  MDBSocials
//
//  Created by Will Oakley on 3/2/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation
import LyftSDK
import CoreLocation

class LyftHelper {
    
    static func getRideEstimate(pickup: CLLocationCoordinate2D, dropoff: CLLocationCoordinate2D, withBlock: @escaping ((Cost)) -> ()){
        print("Getting lyft estimate")
        LyftAPI.costEstimates(from: pickup, to: dropoff, rideKind: .Standard) { result in
            result.value?.forEach { costEstimate in
                print("Finished")
                withBlock(costEstimate)
            }
        }
    }
}
