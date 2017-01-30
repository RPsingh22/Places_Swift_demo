//
//  MockNavigationController.swift
//  GMPlaces_Swift_demo
//
//  Created by Tina Gupta on 30/01/17.
//  Copyright © 2017 Tina gupta. All rights reserved.
//
//@Class: This class is use for mocking the transisitions of UINavigationController.

import UIKit

class MockNavigationController: UINavigationController {
    var pushedViewController = UIViewController()
    internal override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class MockViewController:UIViewController{
    var rootViewController = UIViewController()
    internal override func dismiss(animated flag: Bool, completion: (() -> Void)?){
        rootViewController = (self.view.window?.rootViewController)!
    }
}
