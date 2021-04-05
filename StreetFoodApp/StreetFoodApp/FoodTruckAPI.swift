//
//  FoodTruck.swift
//
//   Created by Dong Yeol Lee on 2021-03-22.
//  Copyright © 2021 Sam Meech-Ward. All rights reserved.
//

import Foundation
import UIKit
struct LastLocation: Codable {
  let latitude: Double
  let longitude: Double
}

struct FoodTruckAPI: Codable {
  let name: String
  let last: LastLocation?
  let phone: String?
  let url: String?
  let description: String?
  let identifier: String
  let email: String?
}

struct ApiFoodTruck: Codable {
  let vendors: [String: FoodTruckAPI]
}



