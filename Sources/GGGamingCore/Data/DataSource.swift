//
//  File.swift
//  
//
//  Created by alip on 28/11/21.
//

import Combine

public protocol DataSource {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
