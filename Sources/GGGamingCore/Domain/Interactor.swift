//
//  File.swift
//  
//
//  Created by alip on 28/11/21.
//

import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {
  private let repository: R

  public init(repository: R) {
    self.repository = repository
  }

  public func execute(request: Request?) -> AnyPublisher<Response, Error> {
    repository.execute(request: request)
  }
}

