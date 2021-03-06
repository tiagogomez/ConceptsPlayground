//: Playground - noun: a place where people can play

import Foundation
import XCTest

struct OptionalElement {
    var optionalName: String?
    var optionalNumber: Int?
    var optionalProperty: OptionalProperty?
}

struct OptionalProperty {
    var optionalText: String?
}

func OptionalReturnIfHasMoreThanThreeCharacters(string: String) -> Int? {
    if string.count <= 3 {
        return nil
    }else{
        return string.count
    }
}

class Optionals: XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOptionalNilDeclaration(){
        let optionalValue: Int? = nil
        XCTAssertEqual(optionalValue, nil, "The optional value should be nil")
    }
    
    func testOptionalDeclaration(){
        let expectedValue = Optional("Santiago")
        let optionalValue: String? = "Santiago"
        XCTAssertEqual(optionalValue, expectedValue, "The optional value shold be Wrapped")
    }
    
    func testForcedUnwrap(){
        let expectedValue = "Desenvuelto"
        let optionalValue: String? = "Desenvuelto"
        if optionalValue != nil{
            let unwrappedValue = optionalValue!     // Never force unwrap an optional that’s nil
            XCTAssertEqual(unwrappedValue, expectedValue, "The optional value should be unwrapped")
        }else {
            XCTFail("The element is not being unwrapped")
        }
    }
    
    func testOptionalBindingToUnwrap(){
        let expectedValue = "Desenvuelto"
        let optionalValue: String? = "Desenvuelto"
        if let unwrappedValue = optionalValue {
            XCTAssertEqual(unwrappedValue, expectedValue, "The optional value should be unwrapped")
        }else {
            XCTFail("The element is not being unwrapped")
        }
    }
    
    func testMultipleOptionalBindingToUnwrap(){
        let expectedValue1: Int = 10
        let expectedValue2: String = "Años"
        let optionalValue1: Int? = 10
        let optionalValue2: String? = "Años"
        if let unwrappedValue1 = optionalValue1,
           let unwrappedValue2 = optionalValue2
        {
            XCTAssertEqual(unwrappedValue1, expectedValue1, "The optional value should be unwrapped")
            XCTAssertEqual(unwrappedValue2, expectedValue2, "The optional value should be unwrapped")
        }else {
            XCTFail("The element is not being unwrapped")
        }
    }
    
    func testOptionalChainingToUnwrap() {
        let expectedElement = OptionalProperty(optionalText: "NotEmpty")
        var optionalElement = OptionalElement(optionalName: nil, optionalNumber: nil, optionalProperty: nil)
        optionalElement.optionalProperty?.optionalText = "NotEmpty"    //This line shold not work because The optionalPropertie is nil
        XCTAssertNotEqual(optionalElement.optionalProperty?.optionalText, expectedElement.optionalText, "The optional value should be nil")
        let optionalProperty = OptionalProperty()
        optionalElement.optionalProperty = optionalProperty
        optionalElement.optionalProperty?.optionalText = "NotEmpty"    //This line shold work because The optionalPropertie is not nil
        XCTAssertEqual(optionalElement.optionalProperty?.optionalText, expectedElement.optionalText, "The element is not being unwrapped")
    }
    
    func testOptionalFunction(){
        let expectedValue = 8
        if let unwrappedValue = OptionalReturnIfHasMoreThanThreeCharacters(string: "Optional"){
            XCTAssertEqual(unwrappedValue, expectedValue, "The optional value should be unwrapped")
        }else {
            XCTFail("The element is not being unwrapped")
        }
        let unwrappedValue = OptionalReturnIfHasMoreThanThreeCharacters(string: "Opt")
        XCTAssertEqual(unwrappedValue, nil, "The optional value should be nil")
    }
    
    func testLongAndShortForm(){
        let expectedValue: Int? = Optional.some(8)
        let shortOptional: Int? = OptionalReturnIfHasMoreThanThreeCharacters(string: "Optional")
        let longOptional: Optional<Int> = OptionalReturnIfHasMoreThanThreeCharacters(string: "Optional")
        XCTAssertTrue(shortOptional == expectedValue && longOptional == expectedValue, "Both values should be Unwrapped")
        
        let emptyExpectedValue: Int? = Optional.none
        let emptyShortOptional: Int? = OptionalReturnIfHasMoreThanThreeCharacters(string: "Opt")
        let emptyLongOptional: Optional<Int> = OptionalReturnIfHasMoreThanThreeCharacters(string: "Opt")
        XCTAssertTrue(emptyShortOptional == emptyExpectedValue && emptyLongOptional == emptyExpectedValue, "Both values should be nil")
    }
}

Optionals.defaultTestSuite.run()
