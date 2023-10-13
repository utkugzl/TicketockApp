//
//  UIApplication+Extension.swift
//  Ticketock
//
//  Created by Utku Güzel on 8.10.2023.
//

import UIKit

extension UIApplication {
    
    /// It is a recursive function that takes one optional parameter, controller, which is of type UIViewController and defaults to the root view controller of the main application window. The purpose of this function is to find the most visible or top view controller in a hierarchy that may include navigation controllers, tab bar controllers, and presented view controllers.
    /// - Parameter controller: which represents a view controller.
    /// - Returns: controller  that represents the topmost view controller in the hierarchy.
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


