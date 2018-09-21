
import Foundation
import XCTest

struct MyOwnFacility{
    let name: String?
    let iD: Int
    
    init(name: String, iD: Int) {
        self.name = name
        self.iD = iD
    }
}

struct MyOwnPark {
    var facilities: [MyOwnFacility]
    let parkID: Int
    
    init(facilities: [MyOwnFacility], parkID: Int) {
        self.facilities = facilities
        self.parkID = parkID
    }
}


class MyOwnFacilityTest: XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testMyOwnFacility(){
        let myFacility = "La jinca"
        let finca = MyOwnFacility(name: myFacility, iD: 1)
        XCTAssertEqual(myFacility, finca.name)
    }
    
    func testMyOwnPark(){
        let mockFacility = "La jinca"
        let finca = MyOwnFacility(name: mockFacility, iD: 1)
        let mockFacilities = [finca]
        let myPark = MyOwnPark(facilities: mockFacilities, parkID: 1)
        XCTAssertEqual(myPark.facilities[0].name, finca.name)
    }
    
    func testMap(){
        let expectedArray = [4,8,12]
        let originalArray = [2,4,6]
        var mappedArray: [Int]?
        mappedArray = originalArray.map{$0*2}
        XCTAssertEqual(mappedArray, expectedArray)
    }
    
    func testFilter(){
        let expectedArray = [6,15,28,1,9]
        let originalArray = [6,15,28,38,42,1,9,36]
        let mappedArray = originalArray.filter{$0 <= 30}
        XCTAssertEqual(mappedArray, expectedArray)
    }
    
    
    
    func testReduce(){
        let expectedValue = 12
        let originalArray = [1,2,3]
        let mappedArray = originalArray.reduce(0) {$0 + ($1*2)}
        XCTAssertEqual(mappedArray, expectedValue)
    }
    
    func testFlatMap(){
        let expectedArray = ["perroflatened","loboflatened","gatoflatened","tigreflatened", "gallinaflatened"]
        let originalArray = [["perro","lobo"],["gato","tigre"],["gallina"]]
        let mappedArray = originalArray.flatMap{$0.map{$0 + "flatened"}}
        XCTAssertEqual(mappedArray, expectedArray)
    }
    
    func testFlatMapOptional(){
        let unExpectedArray = ["perro", nil, "gato", nil, nil, "chorizo"]
        let expectedArray = ["perro", "gato", "chorizo"]
        let originalArray = ["perro", "sal", "gato", "nil", "/", "chorizo"]
        let mappedArray = originalArray.map{$0.count > 3 ? $0 : nil}
        let flatMappedArray = originalArray.flatMap{$0.count > 3 ? $0 : nil}
        XCTAssertEqual(mappedArray, unExpectedArray)
        XCTAssertEqual(flatMappedArray, expectedArray)
    }
    
    func testCompactMap(){
        let expectedArray = ["perro", "gato", "chorizo"]
        let originalArray = ["perro", nil, "gato", nil, nil, "chorizo"]
        let mappedArray = originalArray.compactMap{$0}
        XCTAssertEqual(mappedArray, expectedArray)
    }
}

MyOwnFacilityTest.defaultTestSuite.run()
