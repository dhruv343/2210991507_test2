//
//  File.swift
//  2210991507_test2
//
//  Created by student-2 on 23/11/24.
//

import Foundation
import UIKit



struct Meal : Codable {
    let category:String
    let name:String
    let calories:Int
    let preparationTime:Int
    let image:String
    let instructions:String
}
