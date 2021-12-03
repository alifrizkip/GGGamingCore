//
//  SearchPresenter.swift
//  
//
//  Created by alip on 28/11/21.
//

import Foundation
import Combine

public class SearchPresenter<Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == String, Interactor.Response == [Response] {

  private var cancellables: Set<AnyCancellable> = []

  private let useCase: Interactor

  @Published public var list: [Response] = []
  @Published public var errorMessage: String?
  @Published public var isLoading: Bool = false
  @Published public var keyword = ""

  public init(useCase: Interactor) {
    self.useCase = useCase

    bindSearchKeyword()
  }

  public func search(keyword: String) {
    if keyword.isEmpty {
      return
    }

    isLoading = true
    useCase.execute(request: keyword)
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

  private func bindSearchKeyword() {
    $keyword
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .sink(receiveValue: search(keyword:))
      .store(in: &cancellables)
  }
}
