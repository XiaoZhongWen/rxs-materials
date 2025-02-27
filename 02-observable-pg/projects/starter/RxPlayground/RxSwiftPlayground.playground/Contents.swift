import Foundation
import RxSwift



/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

example(of: "just, of, from") {
  // 1
  let one = 1
  let two = 2
  let three = 3

  // 2
    let observable = Observable<Int>.just(one)
    let observable2 = Observable.of(one, two, three)
    let observable3 = Observable.of([one, two, three])
    let observable4 = Observable.from([one, two, three])
}

example(of: "subscribe") {
    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of(one, two, three)
//    observable.subscribe { event in
//        print(event)
//        if let element = event.element {
//            print(element)
//        }
//    }

    observable.subscribe(onNext: { element in
        print(element)
    })
}

example(of: "empty") {
    let observable = Observable<Any>.empty()
    observable.subscribe(onNext: {element in
        print(element)
    }, onCompleted: {
        print("Completed")
    })
}

example(of: "never") {
    let observable = Observable<Void>.never()
    let disposebag = DisposeBag()
    observable.do(onSubscribe:{
        print("onSubscribe")
    }).subscribe(onNext: { element in
        print(element)
    }, onCompleted: {
        print("onCompleted")
    }, onDisposed: {
        print("onDisposed")
    }).disposed(by: disposebag)
}

example(of: "range") {
    let observable = Observable.range(start: 1, count: 10)
    observable.subscribe(onNext: {i in
        let n = Double(i)
        let fibonacci = Int(
                ((pow(1.61803, n) - pow(0.61803, n)) /
                  2.23606).rounded()
              )
        print(fibonacci)
    }, onCompleted: {
        print("Completed")
    })
}

example(of: "dispose") {
    let disposeBag = DisposeBag()
    let observable = Observable.of("A", "B", "C")
    observable.subscribe { event in
        print(event)
    }.disposed(by: disposeBag)
}

example(of: "create") {
    let disposeBag = DisposeBag()
    Observable<String>.create { observer in
        observer.onNext("1")
        observer.onCompleted()
        observer.onNext("?")
        return Disposables.create()
    }.subscribe(onNext: {
        print($0)
    }, onError: {
        print($0)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })
    .disposed(by: disposeBag)
}
