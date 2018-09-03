//: Playground - noun: a place where people can play

import UIKit

/*
 闭包:函数是闭包的一种，类似于OC语言的block
 闭包表达式(匿名函数)
 作用：能够捕获上下文中的值、延时执行
 OC中block格式
 retureType(^blockName)(parameterType) = ^(parameters) {
 // 执行的代码
 };
 */
/** 无参无返回值. */
#if false
// 1.声明一个闭包常量，类型是：((参数：参数类型）-> (返回值))
let closure : () -> Void
// 2.给闭包赋值
/**
 {
 (参数) -> 返回值类型 in
 执行语句
 }
 in关键字的目的是便于区分返回值和执行语句
 闭包表达式的类型和函数的类型一样, 是参数加上返回值, 也就是in之前的部分
 */
closure = {
    () -> Void in
    print("我是一个闭包")
}
closure()   // 调用
#else
/**
 上面的三步可以整合为下面的代码
 */
let closure : () -> Void = {
    () -> Void in
    print("我是一个闭包")
}
closure()   // 调用
#endif

/** 无参无返回值. */
let closure1 : () -> Void = {
    () -> Void in
    print("我是一个闭包")
}
closure1()   // 调用
/** 有参无返回值. */
let closure2 : (_ a : Int) -> Void = {
    (a : Int) -> Void in
    print("\(a)")
}
closure2(30)
/** 无参有返回值. */
let closure3 : () -> Int = {
    () -> Int in
    return 33
}
print("\(closure3())")
/** 有参有返回值. */
let closure4 : (_ a : Int) -> Int = {
    (a : Int) -> Int in
    return a + 1
}
print("\(closure4(90))")

// MARK: 闭包的简化

var myClosure: (Int , Int ) -> Int = {
    (a: Int , b: Int) -> Int in
    return a * b
}
// 第一次简化 类型自动推导 可以根据参数推断
myClosure = {
    (a, b) in
    return a * b
}
// 第二次简化 如果函数体只包含一句，return 代码可省略
myClosure = {
    (a, b) in a * b
}
/* 第三次简化
 被捕获的参数列表中，含有a、b，下标从0开始，可通过"$"获取。
 编译器亦可通过，捕获列表自行推断出参数。
 故可省略参数列表 （a, b）和 关键字 in
 */
myClosure = {
    $0 * $1
}

// MARK: 闭包的几种使用方法

// MARK: 闭包作为函数返回值：函数的返回值是一个闭包
func countingClosure() -> () -> Int {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}
print("\(countingClosure()())")

// 用关键字“typealias”先声明一个闭包的数据类型
typealias DoubleIntAndInt = (Int , Int) -> Int

let testClosure: DoubleIntAndInt = {
    (a , b) in
    return a * b
}
print("\(testClosure(2, 10))")

// MARK: 尾随闭包
//第二个参数：闭包 (String)->(Void)
func post(url : String, succesce : (_ JSONData : String) -> Void) {
    
    let data : String = "json数据"
    succesce(data)
}
post(url: "https://github.com/OmegaGo2014/Swift-notes") { (JSONData : String) in
    print("\(JSONData)")
}
// MARK: 逃逸闭包
/**
 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
 定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的
 例如：
 很多启动异步操作的函数接受一个闭包参数作为 completion handler。
 这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。
 在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用
 */
func requestData(url : String, success : @escaping (_ data : String) -> Void, failure: ((_ error: String) -> Void)) {
    print("函数开始执行")
    success("json数据包")
    print("函数执行完毕")
}
requestData(url: "www.baidu.com", success: { (str) in
    print("这是接收的数据：\(str)")
}) { (error) in
    print("\(error)")
}

// MARK: 自动闭包
/**
 自动闭包是一种自动创建的闭包，
 作用：包装传递给函数作为参数的表达式。
 特点：自动闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。
 好处：能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
 */

var arrM = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(arrM.count)

let autoClosure = {
    arrM.remove(at: 0)
}
print(arrM.count)
// 这里闭包并没有调用，故打印出 "5"
print("删除了\(autoClosure())，数组中剩余个数为\(arrM.count)")
// 这里闭包调用了，故打印出 "4"

func removeObj(closure addObj : () -> String) {
    print("删除了\(addObj())!")
}
// 这两个方法调用是等效的
#if false
removeObj(closure: autoClosure)
#else
removeObj { () -> String in
    arrM.remove(at: 0)
}
print(arrM.count)
#endif

/**
 @autoclosure
 下面的代码和上面是等效的
 不过它并没有接受一个显式闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。
 现在可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。
 @autoclosure作用就是将参数自动转化为一个闭包
 注意：过度使用 @autoclosure 会让你的代码变得难以理解，上下文和函数名应该能够清晰地表明求值是被延迟执行的。
 */
func anotherRemove(closure test: @autoclosure () -> String) {
    //    let test : (String) -> String = {
    //        (str : String) -> String in
    //        return str
    //    }
    // 这里其实就是自动实现了这个闭包，我们只需要手动调用就可以得到返回的字符串
    print("\(test())!")
}
anotherRemove(closure: "闭包变形记")
func autoclosureTest(closure test : @autoclosure () -> Int) {
    //    @autoclosure () -> Int    等价于
    //    let test : (Int) -> Int = {
    //        (num : Int) -> Int in
    //        return num
    //    }
    print("\(test())")
}
autoclosureTest(closure: 20180827)
// MARK: "逃逸"的自动闭包
// 声明一个数组：数组数据类型是闭包
var arrayM: [() -> String] = []

/**
 这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用。
 因此，closure 参数必须允许“逃逸”出函数作用域。
 */
func addObj(_ closure: @escaping @autoclosure () -> String) {
    //    自动创建了一个闭包
    //    let test : (String) -> String = {
    //        (str : String) -> String in
    //        return str
    //    }
    arrayM.append(closure)
}
addObj("王楠")
addObj("Edwin Javis")
addObj(arrM.remove(at: 0))
addObj(arrM.remove(at: 0))

print("添加了\(arrayM.count)个元素.")

for obj in arrayM {
    print("\(obj())")
}
