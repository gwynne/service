import XCTest
import Service
import Configs

class ServiceTests: XCTestCase {
    func testHappyPath() throws {
        let config = Config()
        var services = Services()
        services.register(PrintLog.self)

        let container = TestContainer(config: config, services: services)
        let log = try container.make(Log.self)
        log.log("hello!")
    }

    func testMultiple() throws {
        var config = Config()
        try config.set("app", "log", to: "all-caps")
        var services = Services()
        services.register(PrintLog.self)
        services.register(AllCapsLog.self)

        let container = TestContainer(config: config, services: services)
        let log = try container.make(Log.self)
        log.log("hello!")
    }

    func testArray() throws {
        var config = Config()
        try config.set("app", "logs", to: ["all-caps", "print"])
        var services = Services()
        services.register(PrintLog.self)
        services.register(AllCapsLog.self)

        let container = TestContainer(config: config, services: services)
        let log = try container.make([Log.self])
        XCTAssertEqual(log.count, 2)
    }

    func testSpecific() throws {
        let config = Config()
        var services = Services()
        services.register(PrintLog.self)
        services.register(AllCapsLog.self)

        let container = TestContainer(config: config, services: services)
        let log = try container.make(AllCapsLog.self)
        print(log)
    }


    static var allTests = [
        ("testHappyPath", testHappyPath),
    ]
}


