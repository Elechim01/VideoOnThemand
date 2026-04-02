//
//  VideoOnThemandTests.swift
//  VideoOnThemandTests
//
//  Created by Michele Manniello on 02/04/26.
//

import XCTest
@testable import VideoOnThemand

final class VideoOnThemandTests: XCTestCase {
    let testUserId = "zglR4HvR0sP3KEqaRGL8Ma5cx5t2"
    func testStreamTermination() async throws {
        let repo = MovieRepository()
     
        let task = Task {
            do {
                let stream = await repo.loadFilms(localUserId: testUserId)
                for try await _ in  stream {
                    // Aspettiamo solo che arrivi qualcosa o che il task viva
                }
            } catch {
                print("Stream terminato con errore (previsto se cancellato): \(error)")
            }
        }
        try await Task.sleep(nanoseconds: 2_000_000_000)
        print("Cancellazione task in corso")
        task.cancel()
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertTrue(task.isCancelled)
    }
    
    func testChronologyStreamTermination() async throws {
        let repo = ChronologyRepository()
        let task = Task {
            do {
                let stream = await repo.loadChronology(localUser: testUserId)
                for try await chronology in stream {
                    
                }
            } catch {
                print("Stream terminato con errore (previsto se cancellato): \(error)")
            }
        }
        // Dormi
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 secondi
        
        // cancelliamo il task
        print("-- Eliminiamo il task--")
        task.cancel()
        // Dormi
        try await Task.sleep(nanoseconds: 1_000_000_000) // 2 secondi
       // let attivi = await repo.activeListenersCount()
       // XCTAssertEqual(attivi, 0,"ERRORE: Ci sono ancora \(attivi) listener attivi! La pulizia è fallita.")
        
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
