//
//  File.swift
//  
//
//  Created by alip on 28/11/21.
//

import Combine

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response

  func list() -> AnyPublisher<[Response], Error>
  func get(id: Int) -> AnyPublisher<Response, Error>
  func isExist(id: Int) -> AnyPublisher<Bool, Error>
  func add(entity: Request) -> AnyPublisher<Bool, Error>
  func delete(id: Int) -> AnyPublisher<Bool, Error>
}
