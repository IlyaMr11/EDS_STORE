//
//  MainProfileModel.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import XCTest
@testable import EDS_Store


final class MainProfileModelTest: XCTestCase {
    var model: MainProfileModel!
    var presenter: MockMainProfilePresenter!
    var view: MockMainProfileView!
    var router: MockProfileRouter!
    
    override func setUpWithError() throws {
        router = MockProfileRouter()
        view = MockMainProfileView()
        model = MainProfileModel()
        presenter = MockMainProfilePresenter(view: view, router: router, model: model)
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

    
    func testLoadName() {
        
        
        let exception = XCTestExpectation()
        presenter.loadName("baz")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            XCTAssertEqual(self?.presenter.error, AlertType.serverError)
            exception.fulfill()
        }
        
        wait(for: [exception], timeout: 1)
    }
    
    func testLoadNameSuccess() {
        let exception = XCTestExpectation()
        presenter.loadName("moroz@y.r")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertNil(self?.presenter.error)
            exception.fulfill()
        }
        
        wait(for: [exception], timeout: 1.3)
    }
    
    func testSignOut() {
        model.signOut()
        XCTAssertNil(UserDefaults.standard.string(forKey: "user"))
        XCTAssertNil(PersonData.shared.currentUser)
    }
    
    func testSetupUser() {
        let exception = XCTestExpectation()
        
        presenter.setupUser()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.presenter.error, .noUser)
            exception.fulfill()
        }
        
        wait(for: [exception], timeout: 0.5)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
