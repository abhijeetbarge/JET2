//
//  EndpointType.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation

protocol EndpointType {

    var baseURL: URL { get }

    var path: String { get }

}
