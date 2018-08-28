//: Playground - noun: a place where people can play

import UIKit
class Tools : NSObject {
    /** 笔. */
    let pen : String = "中性笔"
}
// MARK: 类
class Student : NSObject {
    // 1.存储属性
    // 如果是对象或者结构体,在没有赋值的情况下通常定义为可选类型
    // 如果是基本属性类型,比如int类型,在没有赋值的情况下,通常直接给一个默认的值0
    var name : String?
    var age : Int = 0
    var chineseScore : Double = 0.0
    var mathScore : Double = 0.0
    
    // 2.延迟存储属性
    // 延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性。
    // 必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。
    // 而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
    // 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
    lazy var tool = Tools()
    // 3.计算属性
    // 除存储属性外，类、结构体和枚举可以定义计算属性。
    // 计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
    
    // 4.只读计算属性
    // 只有 getter 没有 setter 的计算属性就是只读计算属性
    // 定义计算属性必须使用 var 关键字，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
    var average : Double {
        // 如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue。
        // 较少写set方法(默认情况下,set方法中有一个系统变量 newValue，新传入的值就再newValue中)
//        set {
//            self.average = newValue
//        }
//        get {
//            return (chineseScore + mathScore) * 0.5
//        }
        // 简化
        return (chineseScore + mathScore) * 0.5
    }
    
    // 5.属性观察器
    // 可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。
    // 你不必为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化。
    var wordsCounting : Int = 0 {
        // willSet 观察器会将新的属性值作为常量参数传入，在 willSet 的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示
        // didSet 观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名 oldValue。如果在 didSet 方法中再次对该属性赋值，那么新值会覆盖旧的值
        // 父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。
        // 在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用
        willSet {   // 在新的值被设置之前调用
            print("准备写下\(newValue)字")
        }
        didSet {    // 在新的值被设置之后立即调用
            if wordsCounting > oldValue {
                print("已经多写了\(wordsCounting - oldValue)个字")
            }
        }
    }
    
    // 6.类属性
    // 属性也可以直接作用于类型本身，这种属性称为类型属性。
    // 类属性用static修饰
    // 类属性只能通过类来访问
    /** 科目数量. */
    static var courseCount = 0
    
    // 全局变量是在函数、方法、闭包或任何类型之外定义的变量
    // 局部变量是在函数、方法或闭包内部定义的变量
    // 全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记lazy修饰符。
    // 局部范围的常量或变量从不延迟计算。
}

let stu : Student = Student()
stu.name = "Edwin Javis"
stu.age = 28
stu.chineseScore = 134
stu.mathScore = 99
stu.wordsCounting = 2
Student.courseCount = 2
print("名字：\(stu.name!)，年龄：\(stu.age)，科目数：\(Student.courseCount)，语文成绩：\(stu.chineseScore)，数学成绩：\(stu.mathScore)，平均成绩：\(stu.average)，考试工具：\(stu.tool.pen)")

// MARK: 结构体
struct Resolution {
    var width = 0
    var height = 0
}
let reso = Resolution() // 结构体实例
// 常量结构体的存储属性：reso实例被声明成了常量，所以就算它的存储属性是变量，也是无法修改的
// 这是因为结构体属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
// 类则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
print("显示器宽为：\(reso.width)")

var reso1 = Resolution()
reso1.width = 100
print("显示器宽为：\(reso1.width)")

// 所有结构体都有一个自动生成的成员逐一构造器
let reso2 = Resolution.init(width: 100, height: 100)
print("显示器宽为：\(reso2.width)，高为：\(reso2.height)")

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)


struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // 将当前音量限制在阈值之内
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// 输出 "7"
print(AudioChannel.maxInputLevelForAllChannels)
// 输出 "7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// 输出 "10"
print(AudioChannel.maxInputLevelForAllChannels)
// 输出 "10"

/**
 Swift 中类和结构体有很多共同点：
 都可以定义属性用于存储值
 都可以定义方法用于提供功能
 都可以定义下标操作使得可以通过下标语法来访问实例所包含的值
 都可以定义构造器用于生成初始化值
 都可以通过扩展以增加默认实现的功能
 都可以实现协议以提供某种标准功能
 
 区别：
 类继承允许一个类继承另一个类的特征
 类中的类型转换允许在运行时检查和解释一个类实例的类型
 类析构器允许一个类实例释放任何其所被分配的资源
 引用计数允许对一个类的多次引用，而结构体总是通过被复制的方式在代码中传递，不使用引用计数。
 
 在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。
 在 Swift 中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。
 类是引用类型
 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
 */
