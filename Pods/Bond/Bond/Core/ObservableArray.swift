//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

/// Abstraction over a type that can be used to encapsulate an array and observe its (incremental) changes.
public protocol ObservableArrayType {
  associatedtype ElementType
  var array: [ElementType] { get }
}

/// A type that can be used to encapsulate an array and observe its (incremental) changes.
public final class ObservableArray<ElementType>: EventProducer<ObservableArrayEvent<Array<ElementType>>>, ObservableArrayType {
  
  /// Batched array operations.
  private var batchedOperations: [ObservableArrayOperation<ElementType>]! = nil
  
  /// Temporary array to work with while batch is in progress.
  private var workingBatchArray: [ElementType]! = nil
  
  /// Returns `true` if batch update is in progress at the moment.
  private var isBatchUpdateInProgress: Bool {
    return batchedOperations != nil
  }
  
  /// The underlying array.
  public var array: [ElementType] {
    get {
      if let workingBatchArray = workingBatchArray {
        return workingBatchArray
      } else {
        return replayBuffer!.last!.sequence
      }
    }
    set {
      next(ObservableArrayEvent(sequence: newValue, operation: ObservableArrayOperation.reset(array: newValue)))
    }
  }
  
  /// Creates a new array with the given initial value.
  public init(_ array: [ElementType]) {
    super.init(replayLength: 1)
    next(ObservableArrayEvent(sequence: array, operation: ObservableArrayOperation.reset(array: array)))
  }
  
  /// Performs batch updates on the array.
  /// Updates must be performed from within the given closure. The closure will receive
  /// an instance of this array for easier manipulation. You should perform updates on received object.
  ///
  /// No event will be generated during the updates. When updates are over, a single .Batch operation
  /// event that contains all operations made to the array will be generated.
  ///
  ///   numbers.performBatchUpdates { numbers in
  ///     numbers.append(1)
  ///     numbers.append(2)
  ///     ...
  ///   }
  public func performBatchUpdates( _ update: @noescape(ObservableArray<ElementType>) -> Void) {
    batchedOperations = []
    workingBatchArray = array
    update(self)
    let operationToSend = ObservableArrayOperation.batch(batchedOperations!)
    let arrayToSend = workingBatchArray!
    workingBatchArray = nil
    batchedOperations = nil
    next(ObservableArrayEvent(sequence: arrayToSend, operation: operationToSend))
  }
  
  public func applyOperation(_ operation: ObservableArrayOperation<ElementType>) {
    if isBatchUpdateInProgress {
      ObservableArray.performOperation(operation, onArray: &workingBatchArray!)
      batchedOperations!.append(operation)
    } else {
      var arrayCopy = array
      ObservableArray.performOperation(operation, onArray: &arrayCopy)
      next(ObservableArrayEvent(sequence: arrayCopy, operation: operation))
    }
  }
  
  private static func performOperation(_ operation: ObservableArrayOperation<ElementType>, onArray array: inout [ElementType]) {
    switch operation {
    case .reset(let newArray):
      array = newArray
    case .insert(let elements, let fromIndex):
      array.insert(contentsOf: elements, at: fromIndex)
    case .update(let elements, let fromIndex):
      for (index, element) in elements.enumerated() {
        array[fromIndex + index] = element
      }
    case .remove(let range):
      array.removeSubrange(range)
    case .batch(let operations):
      for operation in operations {
        ObservableArray.performOperation(operation, onArray: &array)
      }
    }
  }
}

public extension ObservableArray {
  
  /// Appends `newElement` to the ObservableArray and sends .Insert event.
  public func append(_ newElement: ElementType) {
    applyOperation(ObservableArrayOperation.insert(elements: [newElement], fromIndex: count))
  }
  
  public func insert(_ newElement: ElementType, at atIndex: Int) {
    applyOperation(ObservableArrayOperation.insert(elements: [newElement], fromIndex: atIndex))
  }
  
  /// Remove an element from the end of the ObservableArray and sends .Remove event.
  public func removeLast() -> ElementType {
    let last = array.last
    if let last = last {
      applyOperation(ObservableArrayOperation.remove(range: count-1..<count))
      return last
    } else {
      fatalError("Dear Sir/Madam, removing an element from the empty array is not possible. Sorry if I caused (you) any trouble.")
    }
  }
  
  /// Removes and returns the element at index `i` and sends .Remove event.
  public func remove(at index: Int) -> ElementType {
    let element = array[index]
    applyOperation(ObservableArrayOperation.remove(range: index..<index+1))
    return element
  }
  
  /// Removes elements in the give range.
  public func removeSubrange(_ range: Range<Int>) {
    applyOperation(ObservableArrayOperation.remove(range: CountableRange(range)))
  }
  
  /// Remove all elements and sends .Remove event.
  public func removeAll() {
    applyOperation(ObservableArrayOperation.remove(range: 0..<count))
  }
  
  /// Append the elements of `newElements` to `self` and sends .Insert event.
  public func extend(_ newElements: [ElementType]) {
    applyOperation(ObservableArrayOperation.insert(elements: newElements, fromIndex: count))
  }
  
  /// Insertes the array at the given index.
  public func insertContentsOf(_ newElements: [ElementType], atIndex i: Int) {
    applyOperation(ObservableArrayOperation.insert(elements: newElements, fromIndex:i))
  }
  
  /// Replaces elements in the given range with the given array.
  public func replaceRange(_ subRange: Range<Int>, with newElements: [ElementType]) {
    let removeOperation = ObservableArrayOperation<ElementType>.remove(range: CountableRange(subRange))
    let insertOperation = ObservableArrayOperation<ElementType>.insert(elements: newElements, fromIndex: subRange.lowerBound)
    applyOperation(ObservableArrayOperation.batch([removeOperation, insertOperation]))
  }
}

extension ObservableArray: Collection {
  
  public func makeIterator() -> ObservableArrayGenerator<ElementType> {
    return ObservableArrayGenerator(array: self)
  }
  
  public func underestimateCount() -> Int {
    return array.underestimatedCount
  }
  
  public var startIndex: Int {
    return array.startIndex
  }
  
  public var endIndex: Int {
    return array.endIndex
  }
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public subscript(position: Int) -> ElementType {
    get {
      return array[position]
    }
    set(newElement) {
      if position == self.count {
        applyOperation(ObservableArrayOperation.insert(elements: [newElement], fromIndex: position))
      } else {
        applyOperation(ObservableArrayOperation.update(elements: [newElement], fromIndex: position))
      }
    }
  }
  
  public func index(after i: Int) -> ElementType {
      return array[i]
  }
  
  public subscript (bounds: Range<Int>) -> ArraySlice<ElementType> {
    get {
      return array[bounds]
    }
    set {
      replaceRange(bounds, with: Array(newValue))
    }
  }
  
  public func formIndex(after i: inout Int) {
    self.array.formIndex(after: &i)
  }
  
  public func index(after i: Int) -> Int {
    if i >= self.array.endIndex {
      return self.array.endIndex
    }
    else {
      return i
    }
  }
}

public struct ObservableArrayGenerator<ElementType>: IteratorProtocol {
  private var index = -1
  private let array: ObservableArray<ElementType>
  
  public init(array: ObservableArray<ElementType>) {
    self.array = array
  }
  
  public mutating func next() -> ElementType? {
    index += 1
    return index < array.count ? array[index] : nil
  }
}


extension ObservableArray : RangeReplaceableCollection {

  public convenience init() {
    self.init([] as [ElementType])
  }

  public func replaceSubrange<C: Collection where C.Iterator.Element == ElementType>(_ subRange: Range<Int>, with newElements: C) {
    replaceRange(subRange, with: Array(newElements))
  }
}

extension ObservableArray : ExpressibleByArrayLiteral {

  public typealias Element = ElementType

  public convenience init(arrayLiteral elements: ElementType ...){
    self.init(elements)
  }
}

public extension ObservableArray where ElementType: Equatable, ElementType: Hashable  {
  
  /// Calculates a difference between the receiver array and the given collection and
  /// then applies the difference as batch updates sending proper batch operation event.
  public func diffInPlace<C: Collection where C.Iterator.Element == ElementType>(_ collection: C) {
    let diff = simpleDiff(Array(self), after: Array(collection))
    
    self.performBatchUpdates { array in
      
      var startIndex = 0
      
      for diffOperation in diff {
        switch diffOperation {
        case .noop(let elements):
          startIndex += elements.count
        case .insert(let elements):
          array.insertContentsOf(elements, atIndex: startIndex)
          startIndex += elements.count
        case .delete(let elements):
          array.removeSubrange(startIndex ..< startIndex + elements.count)
        }
      }
    }
  }
}

public extension EventProducerType where EventType: ObservableArrayEventType {
  
  private typealias ElementType = EventType.ObservableArrayEventSequenceType.Iterator.Element
  
  /// Wraps the receiver into another array. This basically creates a array of arrays
  /// with with a single element - the receiver array.
  public func lift() -> ObservableArray<Self> {
    return ObservableArray([self])
  }
  
  /// Map overload that simplifies mapping of observables that generate ObservableArray events.
  /// Instead of mapping ObservableArray events, it maps the array elements from those events.
  public func map<T>(_ transform: (ElementType) -> T) -> EventProducer<ObservableArrayEvent<LazyMapSequence<Self.EventType.ObservableArrayEventSequenceType, T>>> {
    return EventProducer(replayLength: replayLength) { sink in
      return observe { arrayEvent in
        let sequence = arrayEvent.sequence.lazy.map(transform)
        let operation = arrayEvent.operation.map(transform)
        sink(ObservableArrayEvent(sequence: sequence, operation: operation))
      }
    }
  }
  
  /// Filter overload that filters array elements instead of its events.
  public func filter(_ includeElement: (ElementType) -> Bool) -> EventProducer<ObservableArrayEvent<LazyFilterSequence<Self.EventType.ObservableArrayEventSequenceType>>> {
    
    var pointers: [Int]? = nil
    
    return EventProducer(replayLength: replayLength) { sink in
      return observe { arrayEvent in
        
        if pointers == nil {
          pointers = pointersFromSequence(arrayEvent.sequence, includeElement: includeElement)
        }
        
        let sequence = arrayEvent.sequence.lazy.filter(includeElement)
        if let operation = arrayEvent.operation.filter(includeElement, pointers: &pointers!) {
          sink(ObservableArrayEvent(sequence: sequence, operation: operation))
        } else {
          sink(ObservableArrayEvent(sequence: sequence, operation: ObservableArrayOperation.reset(array: Array(sequence))))
        }
      }
    }
  }
  
  /// Creates a array from the observable.
  /// If the observable is already a array, returns that array.
  public func crystallize() -> ObservableArray<ElementType> {
    if let array = self as? ObservableArray<ElementType> {
      return array
    }
    
    var capturedArray: [ElementType] = []
    observe{ capturedArray = Array($0.sequence) }.dispose()
    
    let array = ObservableArray<ElementType>(capturedArray)
    array.deinitDisposable += skip(replayLength).observe { [weak array] event in
      array?.applyOperation(event.operation)
      return
    }
    return array
  }
}

public extension EventProducerType where EventType: ObservableArrayEventType, EventType.ObservableArrayEventSequenceType: Collection {
  
  private typealias _ElementType = EventType.ObservableArrayEventSequenceType.Iterator.Element
  
  /// Map overload that simplifies mapping of observables that generate ObservableArray events.
  /// Instead of mapping ObservableArray events, it maps the array elements from those events.
  public func map<T>(_ transform: (_ElementType) -> T) -> EventProducer<ObservableArrayEvent<LazyMapCollection<Self.EventType.ObservableArrayEventSequenceType, T>>> {
    return EventProducer(replayLength: replayLength) { sink in
      return observe { arrayEvent in
        let sequence = arrayEvent.sequence.lazy.map(transform)
        let operation = arrayEvent.operation.map(transform)
        sink(ObservableArrayEvent(sequence: sequence, operation: operation))
      }
    }
  }
}
