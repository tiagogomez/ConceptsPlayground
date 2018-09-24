
import Foundation
import XCTest

class FilterMapReduceTest: XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMultiplyingEachElementWithMap(){
        let expectedArray = [4,8,12]
        let originalArray = [2,4,6]
        var mappedArray: [Int]?
        mappedArray = originalArray.map({   //mappedArray = originalArray.map{$0*2}
            (value: Int) -> Int in
            return value * 2
        })
        XCTAssertEqual(mappedArray, expectedArray, "Each elemet inside the mappedArray should be twice the element inside the original Array")
    }
    
    func testFilteringNumbersGreaterThanAnotherNumber(){
        let expectedArray = [6,15,28,1,9]
        let originalArray = [6,15,28,38,42,1,9,36]
        let mappedArray = originalArray.filter {    //let mappedArray = originalArray.filter{$0 <= 30}
            (value: Int) -> Bool in
            return (value <= 30)
        }
        XCTAssertEqual(mappedArray, expectedArray, "Each elemet inside the mappedArray should be Less than 30")
    }
    
    func testReducingAnArrayWithAnOperation(){
        let expectedValue = 12
        let originalArray = [1,2,3]
        let mappedArray = originalArray.reduce((0)) {   //let mappedArray = originalArray.reduce(0) {$0 + ($1*2)}
            (current: Int, value: Int) in
            current + (value * 2)
        }
        XCTAssertEqual(mappedArray, expectedValue, "The elemet inside mappedArray should be the summation of each element mutiplied by 2")
    }
    
    func testFlateningAnArrayOfArraysIntoOneArray(){
        let expectedArray = ["perroflatened","loboflatened","gatoflatened","tigreflatened", "gallinaflatened"]
        let originalArray = [["perro","lobo"],["gato","tigre"],["gallina"]]
        let mappedArray = originalArray.flatMap {   //let mappedArray = originalArray.flatMap{$0.map{$0 + "flatened"}}
            (array: [String]) in
            return array.map({ (value: String) -> String in
                return value + "flatened"
            })
        }
        XCTAssertEqual(mappedArray, expectedArray, "MappedArray should be only one array with Strings")
    }
    
    func testFilteringNilElementsWithFlatMap(){
        let unExpectedArray = ["perro", nil, "gato", nil, nil, "chorizo"]
        let expectedArray = ["perro", "gato", "chorizo"]
        let originalArray = ["perro", "sal", "gato", "nil", "/", "chorizo"]
        let mappedArray = originalArray.map {   //let mappedArray = originalArray.map{$0.count > 3 ? $0 : nil}
            (value: String) -> String? in
            if value.count > 3{
                return value
            }else{
                return nil
            }
            
        }
        let flatMappedArray = originalArray.flatMap {   //let flatMappedArray = originalArray.flatMap{$0.count > 3 ? $0 : nil}
            (value: String) -> String? in
            if value.count > 3{
                return value
            }else{
                return nil
            }
        }
        XCTAssertEqual(mappedArray, unExpectedArray, "The mappedArray Should have strings and nil Elements")
        XCTAssertEqual(flatMappedArray, expectedArray, "The mappedArray Should not have nil Elements")
    }
    
    func testFilteringNilElementsWithCompactMap(){
        let expectedArray = ["perro", "gato", "chorizo"]
        let originalArray = ["perro", nil, "gato", nil, nil, "chorizo"]
        let mappedArray = originalArray.compactMap {    //let mappedArray = originalArray.compactMap{$0}
            (value: String?) -> String? in
            return value
        }
        XCTAssertEqual(mappedArray, expectedArray, "The mappedArray Should not have nil Elements")
    }
}

FilterMapReduceTest.defaultTestSuite.run()
