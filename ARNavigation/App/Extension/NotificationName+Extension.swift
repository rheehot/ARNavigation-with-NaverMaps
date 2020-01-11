//
//  NotificationName+Extension.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/08.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let locationPermissionDenied = Notification.Name("locationPermissionDenied")
    
    static let didSuccessUpdatingAllLocationTasks = Notification.Name("didSuccessUpdatingAllLocationTasks")
    
    static let didFailUpdatingAllLocationTasks = Notification.Name("didFailUpdatingAllLocationTasks")
}
