//
//  File.swift
//  
//
//  Created by alip on 28/11/21.
//

import Combine

public protocol Repository {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
