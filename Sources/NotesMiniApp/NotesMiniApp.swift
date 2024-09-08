// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
public struct NotesMiniApp {
    static public func createViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "ViewController", bundle: Bundle.module)
        return storyboard.instantiateInitialViewController() as! ViewController
    }
}
