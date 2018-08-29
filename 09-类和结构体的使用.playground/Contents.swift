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
    // 类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
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

// MARK: 继承的使用
// 1.定义一个基类
// 不继承于其它类的类，称之为基类。
// Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为基类。
class Superman {
    /** 名字. */
    var name: String?
    /** 能力. */
    var power: String?
    /** 年龄. */
    var age: Int = 0
    
    /** 描述. */
    var description: String? {
        return ("\(power ?? "超能力")")
    }
    func savePeople() -> Void {
        print("救人")
    }
}
// 2.生成子类
class Ironman : Superman {
    /** 是否是神盾局的. */
    var isShield = true
    // 重写属性
    // 可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。
    // 但是不可以将一个继承来的读写属性重写为一个只读属性。
    // 如果你在重写属性中提供了 setter，那么你也一定要提供 getter。
    // 如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。
    override var description: String? {
        return super.description! + "是我的超能力"
    }
    // 重写方法
    override func savePeople() {
        print("我飞着去救人")
    }
}
let ironman = Ironman()
ironman.savePeople()

/**
 防止重写
 通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。
 如果重写了带有final标记的方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final 的。
 可以通过在关键字class前添加final修饰符（final class）来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
 */
final class Friday : Ironman {
    // 默认构造器
    override init() {
        super.init()
        power = "救人"
    }
}
let friday = Friday()
print(friday.description!)

class Apple {
    var color: String?
    var price: Float
    
    init(price: Float) {
        self.price = price
    }
    // 前面有_ 外部不显示变量名
    init(price: Float, _ color: String) {
        self.color = color
        self.price = price
    }
}
let apple = Apple.init(price: 10.0)
let a = Apple.init(price: 10, "红色")

class Person {
    var name: String?
    init(name: String) {
        self.name = name
    }
    // 类的构造器代理规则
    // 1.为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
    // 2.指定构造器必须调用其直接父类的的指定构造器。
    // 3.便利构造器必须调用同类中定义的其它构造器。
    // 4.便利构造器必须最终导致一个指定构造器被调用。
    // 既指定构造器必须总是向上代理，便利构造器必须总是横向代理
    
    // 两段式构造：Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
    /**
     阶段 1
     某个指定构造器或便利构造器被调用。
     完成新实例内存的分配，但此时内存还没有被初始化。
     指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
     指定构造器将调用父类的构造器，完成父类属性的初始化。
     这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
     当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
     阶段 2
     从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
     最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。
     */
    /** 便利构造器. */
    convenience init() {
        self.init(name: "Javis")
    }
    /** 必要构造器. */
    // 在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器
    // 在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类
    // 在重写父类中必要的指定构造器时，不需要添加override修饰符，但是要添加required修饰符
}
class SomeClass {
    // 如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值
    // 每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性
    // 这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值
    let someProperty: String = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return "Javis"
    }()
}
