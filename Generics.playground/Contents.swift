import Foundation
import XCTest

struct genericQueue<Element> {
    
    var elements: [Element] = []
    
    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
}

extension genericQueue {
    var lastItem: Element? {
        return elements.isEmpty ? nil : elements[elements.count - 1]
    }
}

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    //The generic T is Straitened as Equatable which means “any type T that conforms to the Equatable protocol.”
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct genericIntStack: Container {
    // original IntStack implementation
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

class GenericsTest: XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGenericQueue() {
        var intsQueue = genericQueue<Int>()
        intsQueue.enqueue(newElement: 1)
        var stringsQueue = genericQueue<String>()
        stringsQueue.enqueue(newElement: "uno")
        XCTAssertTrue(type(of: intsQueue.dequeue()) == Int?.self)
        XCTAssertTrue(type(of: stringsQueue.dequeue()) == String?.self)
    }
    
    func testGenericExtension() {
        var intsQueue = genericQueue<Int>()
        intsQueue.enqueue(newElement: 1)
        var stringsQueue = genericQueue<String>()
        stringsQueue.enqueue(newElement: "uno")
        XCTAssertTrue(type(of: intsQueue.lastItem) == Int?.self)
        XCTAssertTrue(type(of: stringsQueue.lastItem) == String?.self)
    }
    
    func testTypeConstraint () {
        let intArray = [5, 7, 8, 15]
        let stringArray = ["Auxilio", "Me desmayo", "Callese"]
        let intIndex = findIndex(of: 7, in: intArray)
        let stringIndex = findIndex(of: "Auxilio", in: stringArray)
        XCTAssertEqual(intIndex, 1)
        XCTAssertEqual(stringIndex, 0)
    }
    
    func testAssociatedType () {
        var intStack = genericIntStack()
        intStack.append(10)
        print("testing", intStack.count)
        XCTAssertEqual(intStack.pop(), 10)
    }
}

GenericsTest.defaultTestSuite.run()
