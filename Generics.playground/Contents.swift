import Foundation
import XCTest

// Generic Structure that contains a Queue of any Type
struct GenericQueue<Element> {
    
    var elements: [Element] = []
    
    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
}

// Extension of the Generic Queue that define a generic attribute
extension GenericQueue {
    var lastItem: Element? {
        return elements.isEmpty ? nil : elements[elements.count - 1]
    }
}

// Generic func that also has a Type Constraint
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    //The generic T is Straitened as Equatable which means “any type T that conforms to the Equatable protocol.”
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// Protocol that contains a Generic associated type
protocol GenericAssociatedTypeContainer {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// Generic structure that conforms a Generic Protocol
struct GenericStack<Element>: GenericAssociatedTypeContainer {
    
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
// Generic structure that conforms a Generic Protocol
struct GenericQueueContainer<Element>: GenericAssociatedTypeContainer {
    
    var items = [Element]()
    mutating func enqueue(_ item: Element) {
        items.append(item)
    }
    
    mutating func dequeue() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.remove(at: 0)
    }
    
    mutating func append(_ item: Element) {
        self.enqueue(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// Using a protocol in its own Associated Type’s Constraint
protocol GenericSuffixableContainer: GenericAssociatedTypeContainer {
    associatedtype Suffix: GenericSuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}
extension GenericStack: GenericSuffixableContainer {
    func suffix(_ size: Int) -> GenericStack {
        var result = GenericStack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
// Generic function with a Where Clause
func genericWhereClauseAllItemsMatch<C1: GenericAssociatedTypeContainer, C2: GenericAssociatedTypeContainer>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}
// Using a Generic Subscript
extension GenericAssociatedTypeContainer {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
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
        var intsQueue = GenericQueue<Int>()
        intsQueue.enqueue(newElement: 1)
        var stringsQueue = GenericQueue<String>()
        stringsQueue.enqueue(newElement: "uno")
        XCTAssertTrue(type(of: intsQueue.dequeue()) == Int?.self, "The type of the element should be Int")
        XCTAssertTrue(type(of: stringsQueue.dequeue()) == String?.self, "The type of the element should be String")
    }
    
    func testGenericExtension() {
        var intsQueue = GenericQueue<Int>()
        intsQueue.enqueue(newElement: 1)
        var stringsQueue = GenericQueue<String>()
        stringsQueue.enqueue(newElement: "uno")
        XCTAssertTrue(type(of: intsQueue.lastItem) == Int?.self, "The type of the element should be Int")
        XCTAssertTrue(type(of: stringsQueue.lastItem) == String?.self, "The type of the element should be String")
    }
    
    func testTypeConstraint() {
        let intArray = [5, 7, 8, 15]
        let stringArray = ["Auxilio", "Me desmayo", "Callese"]
        let intIndex = findIndex(of: 7, in: intArray)
        let stringIndex = findIndex(of: "Auxilio", in: stringArray)
        XCTAssertEqual(intIndex, 1, "The index of 7 should be 1")
        XCTAssertEqual(stringIndex, 0, "The index of Auxilio should be 0")
    }
    
    func testAssociatedType() {
        var intStack = GenericStack<Int>()
        intStack.append(10)
        var stringStack = GenericStack<String>()
        stringStack.append("Diez")
        XCTAssertTrue(type(of: intStack.pop()) == Int.self, "The type of the element should be Int")
        XCTAssertTrue(type(of: stringStack.pop()) == String.self, "The type of the element should be String")
    }
    
    func testProtocolInItsAssociatedTypeConstraints() {
        var intsStack = GenericStack<Int>()
        intsStack.append(4)
        intsStack.append(1)
        intsStack.append(0)
        intsStack.append(7)
        let suffix = intsStack.suffix(3)
        XCTAssertEqual(suffix.items, [1,0,7], "The items in suffix should be the last three")
    }
    
    func testGenericWhereClause() {
        var stringStack = GenericStack<String>()
        stringStack.push("Auxilio")
        stringStack.push("Me Desmayo")
        stringStack.push("Callese")
        
        var stringQueue = GenericQueueContainer<String>()
        stringQueue.enqueue("Auxilio")
        stringQueue.enqueue("Me Desmayo")
        stringQueue.enqueue("Callese")
        
        let allMatch = genericWhereClauseAllItemsMatch(stringStack, stringQueue)
        XCTAssertTrue(allMatch, "The function should return true, even if the parameters have different types")
    }
}

GenericsTest.defaultTestSuite.run()
