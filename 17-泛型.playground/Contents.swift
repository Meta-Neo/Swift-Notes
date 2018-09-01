//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
// MARK: - 泛型函数
func swapTwoValues<T>(_ a: inout T, _ b: inout T) -> (T, T){
    let temporaryA = a
    a = b
    b = temporaryA
    return (a, b)
}

var a = "str1", b = "str2"
print("\(swapTwoValues(&a, &b))")

var m = 3, n = 5
print("\(swapTwoValues(&m, &n))")

// MARK: - 泛型约束
// T类型是NSObject的子类，U类型是遵循的protocol的实例
func someFunction<T: NSObject, U: Equatable>(someT: T, someU: U) {
    // 这里是泛型函数的函数体部分
}
// find the index of target string
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]

if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// To limit the element type in the Generics
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// 栈中现在有 4 个字符串
stackOfStrings.pop()

var stackOfInts = Stack<Int>()
stackOfInts.push(1)
stackOfInts.push(2)
stackOfInts.push(3)
stackOfInts.push(4)
stackOfInts.pop()

// 扩展泛型
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
print("\(stackOfStrings.topItem!)")
print("\(stackOfInts.topItem!)")

// MARK: - 关联类型
/*
 定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。
 关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。
 通过 associatedtype 关键字来指定关联类型
 */
protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
struct IntStack: Container {
    // IntStack的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() {
        items.removeLast()
    }
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// 对Stack进行扩展，让其也遵循Container协议
extension Stack: Container {
    // MARK: ContainerProtocol
    mutating func append(_ item: Stack<Element>.ItemType) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
struct StackTest<Element>: Container {
    // 原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // 协议实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}




