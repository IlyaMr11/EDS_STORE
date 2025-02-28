//
//  RegistrationModelTest.swift
//  EDS_StoreTests
//
//  Created by Илья Морозов on 18.02.2025.
//

import XCTest
@testable import EDS_Store

final class RegistrationModelTest: XCTestCase {
    
    var model: RegistrationModel!
    var error: AlertType?
        
    
    override func setUpWithError() throws {
        model = RegistrationModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCheckPassword() {
        let fields = Fields(password: "foo", login: "bar", name: "baz", confirmPassword: "foo")
        let error = model.checkFields(fields: fields)
        XCTAssertEqual(error, AlertType.password)
    }
    
    func testCheckLogin() {
        let fields = Fields(password: "Ilya26.", login: "bar", name: "bazar", confirmPassword: "foo")
        let error = model.checkFields(fields: fields)
        XCTAssertEqual(error, AlertType.email)
    }
    
    func testCheckConfirmPassword() {
        let fields = Fields(password: "Ilya26.", login: "ilya@mail.ru", name: "bazar", confirmPassword: "Ily27.")
        let error = model.checkFields(fields: fields)
        XCTAssertEqual(error, AlertType.confirmPassword)
    }
    
    func testCheckName() {
        let fields = Fields(password: "Ilya26.", login: "ilya@mail.ru", name: "!!!!", confirmPassword: "Ily26.")
        let error = model.checkFields(fields: fields)
        XCTAssertEqual(error, AlertType.userName)
    }
    
    func testCreateUserNoValidData() {
        let fields = Fields(password: "baz", login: "bar", name: "foo", confirmPassword: "bar")
        let exception = XCTestExpectation()
        
        model.createUser(fields: fields) { [weak self] error in
            self?.error = error
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            XCTAssertEqual(self?.error, .password)
            exception.fulfill()
        }
        
        wait(for: [exception], timeout: 1)
    }
    
    func testCreateUserUser() {
        let fields = Fields(password: "Ilya26.", login: "moroz@y.r", name: "foo", confirmPassword: "Ilya26.")
        let exception = XCTestExpectation()
        
        model.createUser(fields: fields) { [weak self] error in
            self?.error = error
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            XCTAssertEqual(self?.error, .loginNoFree)
            exception.fulfill()
        }
        
        wait(for: [exception], timeout: 1.5)
    }
    
//MARK: - UPDATE FIELDS BEFORE RUN THIS TEST
//    func testCrerateUserNoError() {
//        let fields = Fields(password: "Mixa17!", login: "mix@g.c", name: "Mixa", confirmPassword: "Mixa17!")
//        
//        let exception = XCTestExpectation()
//        model.createUser(fields: fields) { [weak self] error in
//            self?.error = error
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//            XCTAssertNil(self?.error)
//            exception.fulfill()
//        }
//        
//        wait(for: [exception], timeout: 1)
//    }
    
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
