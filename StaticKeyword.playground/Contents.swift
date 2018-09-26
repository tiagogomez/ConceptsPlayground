//: Playground - noun: a place where people can play

import Foundation
import XCTest

class StaticTestClass {
    let instanceProperty = "Instancia"
    static let classProperty = "Estatico"
    
    func instanceFunction() -> String{
        print("soy función de instancia")
        return "Instancia"
    }
    
    static func classFunction() -> String{
        print("soy función de clase")
        return "Estatico"
    }
}

class StaticKeyword: XCTestCase{
    
    func testInstanceVar(){
        let instancedClass = StaticTestClass()
        XCTAssertEqual(instancedClass.instanceProperty, "Instancia", "You should have an instance of the class")
    }
    
    func testClassVar(){
        XCTAssertEqual(StaticTestClass.classProperty, "Estatico", "You should acces directly on the type")
    }
    
    func testInstanceMethod(){
        let instancedClass = StaticTestClass()
        XCTAssertEqual(instancedClass.instanceFunction(), "Instancia", "You should have an instance of the class")
    }
    
    func testClassMethod(){
        XCTAssertEqual(StaticTestClass.classFunction(), "Estatico", "You should acces directly on the type")
    }
}
StaticKeyword.defaultTestSuite.run()
