//
//  NetworkTest.swift
//  UmbaTests
//
//  Created by CWG Mobile Dev on 09/01/2022.
//

import XCTest
@testable import Umba
import Moya

class NetworkTest: XCTestCase {
    var coreDataHelper: CoreDataHelper!
    var networkManager: MoyaProvider<NetworkManager>!

      override func setUp() {
          super.setUp()
          networkManager = MoyaProvider<NetworkManager>(plugins: [VerbosePlugin(verbose: true)])
          coreDataHelper = CoreDataHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
      }

    func test_get_popular_movies(){
        networkManager.request(.getPopularMovies(page: "0"), completion:  { (result) in
            var response : Response?
                  if case let .success(res) = result {
                      response = res
                      print("user.statusCode \(res.statusCode)")
                  }
            print("user.statusCode \(response?.statusCode)")
            XCTAssertEqual(response?.statusCode, 200)//(response?.statusCode == 200)
              })
           
          }
    func test_get_saved_movies(){
        let response =  coreDataHelper.getSavedMovies(name: name)
        print("get saved data \(response?.totalPages)")
        XCTAssert((response?.results?.count ?? 0) < 1)
      
    }
    
}
