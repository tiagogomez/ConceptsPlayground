//: Playground - noun: a place where people can play

import Foundation
import XCTest

class StaticTestClass {
    let instanceProperty = "Instancia"
    static let classProperty = "Estático"
    static private var counter = 0
    
    func instanceFunction() -> String{
        print("soy función de instancia")
        return "Instancia"
    }
    
    class func classFunction() -> String{
        print("soy función de clase")
        return "Estático"
    }
    
    func getCounter() -> Int{
        return type(of: self).counter
    }
    
    func updateCounter() {
        type(of: self).counter += 1
    }
    
//    class func getInstanceProperty() -> String {      Should not Work 
//        return instanceProperty
//    }
}

class StaticKeywordTests: XCTestCase{
    
    func testInstanceVar(){
        let instancedClass = StaticTestClass()
        XCTAssertEqual(instancedClass.instanceProperty, "Instancia", "You should have an instance of the class")
    }
    
    func testClassVar(){
        XCTAssertEqual(StaticTestClass.classProperty, "Estático", "You should access directly on the type")
    }
    
    func testInstanceMethod(){
        let instancedClass = StaticTestClass()
        XCTAssertEqual(instancedClass.instanceFunction(), "Instancia", "You should have an instance of the class")
    }
    
    func testClassMethod(){
        XCTAssertEqual(StaticTestClass.classFunction(), "Estático", "You should access directly on the type")
    }
    
    func testClassVarFromAnIntancedClass(){
        let instancedClass = StaticTestClass()
        let classVar = type(of: instancedClass).classProperty
        XCTAssertEqual(classVar, "Estático", "You should access directly on the type")
    }
    
    func testClassVariableUpdateIsTheSameAcrossInstances(){
        let instancedClass1 = StaticTestClass()
        let instancedClass2 = StaticTestClass()
        instancedClass1.updateCounter()
        instancedClass2.updateCounter()
        XCTAssertEqual(instancedClass1.getCounter(), 2)
        XCTAssertEqual(instancedClass2.getCounter(), 2)
    }
}
StaticKeywordTests.defaultTestSuite.run()
