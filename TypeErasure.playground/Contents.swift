
import Foundation
import XCTest

protocol ConsoleFactoryProtocol {
    associatedtype ConsoleType
    func produce() -> ConsoleType
}

struct NintendoConsole {
    let console: String
}

struct SonyConsole {
    let console: String
}

struct MicrosoftConsole {
    let console: String
}

struct NintendoFactory: ConsoleFactoryProtocol {
    
    typealias ConsoleType = NintendoConsole
    
    func produce() -> NintendoFactory.ConsoleType {
        print("producing Nintendo Switch ...")
        return NintendoConsole(console: "Nintendo Switch")
    }
}

struct PokemonFactory: ConsoleFactoryProtocol {
    
    typealias ConsoleType = NintendoConsole
    
    func produce() -> PokemonFactory.ConsoleType {
        print("producing Nintendo 3DS ...")
        return NintendoConsole(console: "Nintendo 3DS")
    }

}

struct SonyFactory: ConsoleFactoryProtocol {
    
    typealias ConsoleType = SonyConsole
    
    func produce() -> SonyFactory.ConsoleType {
        print("producing Play Station 4 ...")
        return SonyConsole(console: "PS4")
    }
}

struct MicrosoftFactory: ConsoleFactoryProtocol {
    
    typealias ConsoleType = MicrosoftConsole
    
    func produce() -> MicrosoftFactory.ConsoleType {
        print("producing Xbox One ...")
        return MicrosoftConsole(console: "Xbox ONE")
    }
}

//Type Erasure Implementation
struct AnyConsoleFactory<ConsoleType>: ConsoleFactoryProtocol {
    
    private let _produce: () -> ConsoleType
    
    init<Factory: ConsoleFactoryProtocol>(_ consoleFactory: Factory) where Factory.ConsoleType == ConsoleType {
        _produce = consoleFactory.produce
    }
    
    func produce() -> ConsoleType {
        return _produce()
    }
}

class TypeErasure: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTypeErasure() {
//        let consoleFactories: [ConsoleFactoryProtocol]  //This line does not work because the compiler does not know the concrete type at compile time
        let factories = [AnyConsoleFactory(NintendoFactory()),
                         AnyConsoleFactory(PokemonFactory())]
        XCTAssertNotNil(factories.map() {$0.produce()}, "The Factories inside the array should work")

    }
}

TypeErasure.defaultTestSuite.run()
