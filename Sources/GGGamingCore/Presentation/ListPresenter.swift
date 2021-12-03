//
//  File.swift
//  
//
//  Created by alip on 28/11/21.
//

import Foundation
import Combine

public class ListPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == [Response] {
  private var cancellables: Set<AnyCancellable> = []

  private let useCase: Interactor

  @Published public var list: [Response] = []
  @Published public var errorMessage: String?
  @Published public var isLoading: Bool = false

  public init(useCase: Interactor) {
    self.useCase = useCase
  }

  public func getList(request: Request?) {
    isLoading = true
    errorMessage = nil
    useCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        case .finished: break
        }
        self.isLoading = false
      }, receiveValue: { list in
        self.list = list
      })
      .store(in: &cancellables)
  }
}
