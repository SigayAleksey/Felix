//
//  CitiesViewModelTests.swift
//  FelixTests
//
//  Created by Alexey Sigay on 01.05.2023.
//

import XCTest
import MapKit
@testable import Felix

final class CitiesViewModelTests: XCTestCase {

    var networkService = NetworkServiceMock()
    @MainActor
    var viewModel = CitiesViewModel(networkService: NetworkServiceMock())
    
    @MainActor
    override func setUpWithError() throws {
        networkService = NetworkServiceMock()
        viewModel = CitiesViewModel(networkService: networkService)
    }

    // MARK: - Initial values
    
    @MainActor
    func testInitialValues() throws {
        // then
        XCTAssertEqual(viewModel.state, .none)
        XCTAssertEqual(viewModel.coordinateRegion, MKCoordinateRegion())
        XCTAssertEqual(viewModel.selectedCity, nil)
        XCTAssertEqual(viewModel.showingCityDetails, false)
        XCTAssertTrue(viewModel.cities.isEmpty)
        XCTAssertTrue(viewModel["networkService"] is CitiesFetching)
    }
    
    // MARK: - getCities(name: String)
    
    @MainActor
    func testArrayOfCitiesWasReceived() async throws {
        // given
        XCTAssertEqual(viewModel.state, .none)
        XCTAssertTrue(viewModel.cities.isEmpty)
        XCTAssertFalse(networkService.fetchCitiesWasCalled)
        let cities = City.Stub.cities
        // when
        networkService.returnValue = cities
        await viewModel.getCities(name: "New")
        // then
        XCTAssertTrue(networkService.fetchCitiesWasCalled)
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
        XCTAssertEqual(viewModel.state, .success(result: cities))
        XCTAssertEqual(viewModel.cities, cities)
    }
    
    @MainActor
    func testEmptyArrayOfCitiesWasReceived() async throws {
        // given
        XCTAssertEqual(viewModel.state, .none)
        XCTAssertTrue(viewModel.cities.isEmpty)
        XCTAssertFalse(networkService.fetchCitiesWasCalled)
        let cities: [City] = []
        // when
        networkService.returnValue = cities
        await viewModel.getCities(name: "New")
        // then
        XCTAssertTrue(networkService.fetchCitiesWasCalled)
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
        XCTAssertEqual(viewModel.state, .success(result: cities))
        XCTAssertEqual(viewModel.cities, cities)
    }
    
    @MainActor
    func testNoCitiesWasReceived() async throws {
        // given
        XCTAssertEqual(viewModel.state, .none)
        XCTAssertTrue(viewModel.cities.isEmpty)
        XCTAssertFalse(networkService.fetchCitiesWasCalled)
        let cities: [City]? = nil
        // when
        networkService.returnValue = cities
        await viewModel.getCities(name: "New")
        // then
        XCTAssertTrue(networkService.fetchCitiesWasCalled)
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
        XCTAssertEqual(viewModel.state, .error(error: NetworkError.serverError))
        XCTAssertTrue(viewModel.cities.isEmpty)
    }
    
    // MARK: - ErrorViewDelegate
    
    @MainActor
    func testCancelActionShouldSetNoneState() async throws {
        // given
        let cities: [City]? = nil
        networkService.returnValue = cities
        await viewModel.getCities(name: "New")
        XCTAssertTrue(networkService.fetchCitiesWasCalled)
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
        XCTAssertEqual(viewModel.state, .error(error: NetworkError.serverError))
        XCTAssertTrue(viewModel.cities.isEmpty)
        // when
        viewModel.cancelAction()
        // then
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
        XCTAssertEqual(viewModel.state, .none)
    }

    @MainActor
    func testRepeatActionShouldDoNothing() async throws {
        // given
        let cities: [City]? = nil
        networkService.returnValue = cities
        await viewModel.getCities(name: "New")
        XCTAssertTrue(networkService.fetchCitiesWasCalled)
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
        XCTAssertEqual(viewModel.state, .error(error: NetworkError.serverError))
        XCTAssertTrue(viewModel.cities.isEmpty)
        // when
        viewModel.repeatAction()
        try await Task.sleep(nanoseconds: 1_000_000)
        // then
        XCTAssertEqual(networkService.fetchCitiesNumberOfCalls, 1)
    }
    
    // MARK: - MapZoomButtonsProtocol
    
    @MainActor
    func testShouldZoomMap() async throws {
        // given
        let center = CLLocationCoordinate2D(latitude: 50, longitude: 20)
        let coordinateRegion = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
        viewModel.coordinateRegion = coordinateRegion
        // when
        viewModel.zoom()
        try await Task.sleep(nanoseconds: 1_000)
        // then
        XCTAssertEqual(viewModel.coordinateRegion.center.latitude, center.latitude)
        XCTAssertEqual(viewModel.coordinateRegion.center.longitude, center.longitude)
        XCTAssertEqual(
            viewModel.coordinateRegion.span.latitudeDelta,
            coordinateRegion.span.latitudeDelta - coordinateRegion.span.latitudeDelta*0.3
        )
        XCTAssertEqual(
            viewModel.coordinateRegion.span.longitudeDelta,
            coordinateRegion.span.longitudeDelta - coordinateRegion.span.longitudeDelta*0.3
        )
    }
    
    @MainActor
    func testShouldOutMap() async throws {
        // given
        let center = CLLocationCoordinate2D(latitude: 50, longitude: 20)
        let coordinateRegion = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
        viewModel.coordinateRegion = coordinateRegion
        // when
        viewModel.out()
        try await Task.sleep(nanoseconds: 1_000)
        // then
        XCTAssertEqual(viewModel.coordinateRegion.center.latitude, center.latitude)
        XCTAssertEqual(viewModel.coordinateRegion.center.longitude, center.longitude)
        XCTAssertEqual(
            viewModel.coordinateRegion.span.latitudeDelta,
            coordinateRegion.span.latitudeDelta + coordinateRegion.span.latitudeDelta*0.3
        )
        XCTAssertEqual(
            viewModel.coordinateRegion.span.longitudeDelta,
            coordinateRegion.span.longitudeDelta + coordinateRegion.span.longitudeDelta*0.3
        )
    }
}

extension CitiesViewModel: PropertyReflectable { }
