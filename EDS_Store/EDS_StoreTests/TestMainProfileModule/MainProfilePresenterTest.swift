//
//  MainProfilePresenterTest.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 16.02.2025.
//

import XCTest
@testable import EDS_Store


final class MainProfilePresenterTest: XCTestCase {
    
    var view: MockMainProfileView!
    var router: MockProfileRouter!
    var builder: MockProfileAssemblyBuilder!
    var model: MockMainProfileModel!
    var presenter: MainProfilePresenter!

    
    override func setUpWithError() throws {
        view = MockMainProfileView()
        router = MockProfileRouter()
        model = MockMainProfileModel()
        builder = MockProfileAssemblyBuilder()
        router.assemblyBuilder = builder
        presenter = MainProfilePresenter(view: view, router: router, model: model)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    
    override func tearDownWithError() throws {
        view = nil
        router = nil
        model = nil
        builder = nil
        presenter = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(router, "router is not nil")
        XCTAssertNotNil(model, "model is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
        XCTAssertNotNil(builder, "builder is not nil")
    }
    
    func testTapOnCell() {
        let index = 5
        presenter.tapOnCell(index: index)
        XCTAssertEqual(router.index, index)
    }
    
    func testSetupUser() {
        model.flag = false
        model.alert = AlertType.email
        
        let expectation = XCTestExpectation(description: "Wait for async code to complete")

           // 3. Запускаем асинхронный код
           presenter.setupUser()

           // 4. Ждем, пока асинхронный код выполнится
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               XCTAssertEqual(self.view.alertName, self.model.alert?.rawValue)
               expectation.fulfill()
           }

          
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testSetupUserTrue() {
        model.flag = true
        
        let expectation = XCTestExpectation(description: "Wait for async code to complete")
        
        presenter.setupUser()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.view.bool, true)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testSignOut() {
        let expectation = XCTestExpectation(description: "Wait for async code to complete")
        presenter.signOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.model.userDefine, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testLoadName() {
        presenter.loadName("baz")
        
        let expectation = XCTestExpectation(description: "Wait for async code to complete")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.model.userLogin, "baz")
            XCTAssertEqual(self?.view.alertName, AlertType.badConnection.rawValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
