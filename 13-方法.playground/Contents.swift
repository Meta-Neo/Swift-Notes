//: Playground - noun: a place where people can play

import UIKit

// MARK: 实例方法
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    // 类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身
    // 只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写self，Swift 假定你是指当前实例的属性或者方法
    func reset() {
        count = 0
        //        self.count = 0  不必写self
    }
    // 实例方法的某个参数名称与实例的某个属性名称相同的时候。
    // 在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。
    // 这时你可以使用self属性来区分参数名称和属性名称。
    // 如果不使用self前缀，Swift 就认为两次使用的x都指的是名称为x的函数参数。
    func isEqualToCurrentCount(by count: Int) -> Bool {
        return self.count > count
    }
}
let counter = Counter()
// 初始计数值是0
counter.increment()
// 计数值现在是1
counter.reset()
// 计数值现在是0
counter.increment(by: 5)
// 计数值现在是6
if counter.isEqualToCurrentCount(by: 6) {
    print("当前计数为6")
}

// 在实例方法中修改值类型的属性
// 默认情况下，值类型的属性不能在它的实例方法中被修改
// 如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；
// 并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x offSetX: Double, y offSetY: Double) {
        x += offSetX
        y += offSetY
    }
    // 在可变方法中给 self 赋值
    mutating func moveTo(x offSetX: Double, y offSetY: Double) {
        self = Point(x: 0 + offSetX, y: 0 + offSetY)
    }
}
var currentP = Point(x: 1.0, y: 1.0)
currentP.moveBy(x: 2.0, y: 3.0)
print("当前点坐标：(\(currentP.x), \(currentP.y))")

currentP.moveTo(x: 5.0, y: 8.0)
print("当前点坐标：(\(currentP.x), \(currentP.y))")


// MARK: 类型方法
// 实例方法是被某个类型的实例调用的方法。
// 你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。
// 在方法的func关键字之前加上关键字static，来指定类型方法。
// 注意：在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。
// 在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
// 类中的self指向这个类型本身，而不是类型的某个实例

class Person {
    // 类还可以用关键字class来允许子类重写父类的方法实现。
    func run(distance : Float) -> Void {
        print("跑了\(distance)米")
    }
}
class Me : Person {
    /** 最低油量. */
    static var minOilMeter : Float = 100.0
    /** 当前油量. */
    var currentOil = 0.0
    
    class func run(distance : Float) -> Void {
        print("飞了\(distance)米")
    }
}
Me.run(distance: 1000)

/** 等级检测. */
struct Tracker {
    /** 玩家已解锁的最高等级. */
    static var highestUnlockedLevel = 1
    /** 当前等级. */
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    // 判断玩家是否升到目标等级
    mutating func advance(to level: Int) -> Bool {
        if Tracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
/** 玩家. */
class Player {
    var tracker = Tracker()
    let playerName: String
    /** 升级. */
    func levelUp(level: Int) {
        Tracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
// 实例一个新的玩家
let player1 = Player(name: "Edwin")
player1.levelUp(level: 1)
print("玩家1当前等级：\(Tracker.highestUnlockedLevel)")

// 实例第二个玩家
let player2 = Player(name: "Javis")
if player2.tracker.advance(to: 6) {
    print("玩家2已经6级了")
} else {
    print("玩家2还没到6级")
}

// MARK: 下标语法
// 下标方法可以通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。
// 定义下标使用subscript关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("\(threeTimesTable[6])")

/** 矩阵. */
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
/** 创建一个2行2列的矩阵. */
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2




