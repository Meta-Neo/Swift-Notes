//: Playground - noun: a place where people can play

import UIKit

class Student : NSObject {
    /**
     // 1> 属性
     如果是对象或者结构体,在没有赋值的情况下通常定义为可选类型
     如果是基本属性类型,比如int类型,在没有赋值的情况下,通常直接给一个默认的值0
     */
    var name : String?
    var age : Int = 0
    var chineseScore : Double = 0.0
    var mathScore : Double = 0.0
    
    // 2> 计算属性
    var average : Double {
        /**
         较少写set方法(默认情况下,set方法中有一个系统变量:newValue.新传入的值就再newValue中)
         如果计算属性属性是一个只读属性,则可以省略get{}
         */
        set { self.average = newValue }
        get { return (chineseScore + mathScore) * 0.5 }
    }
    // 3> 类属性
    /*
     类属性用static修饰
     类属性只能通过类来访问
     */
    static var courseCount = 0
}

// 创建类的对象
let stu : Student = Student()
stu.name = "Edwin Javis"
stu.age = 28
stu.chineseScore = 134
stu.mathScore = 99
print("名字：\(stu.name!), 年龄：\(stu.age), 语文成绩：\(stu.chineseScore), 数学成绩：\(stu.mathScore)")

// 获取平均成绩
print(stu.average)

Student.courseCount = 2
print(Student.courseCount)

// MARK: 监听类的属性
class Person : NSObject {
    var name : String? {
        // 可以给newValue自定义名称
        willSet (new){ // 属性即将改变,还未改变时会调用的方法
            // 在该方法中有一个默认的系统属性newValue,用于存储新值
            print(name ?? "Javis")
            if new != nil {
                print(new!)
            }
        }
        // 可以给oldValue自定义名称
        didSet (old) { // 属性值已经改变了,会调用的方法
            // 在该方法中有一个默认的系统属性oldValue,用于存储旧值
            print(name ?? "Javis")
            if old != nil {
                print(old!)
            }
        }
    }
    var age : Int = 0
    var height : Double = 0.0
}

let p : Person = Person()

// 在赋值时,监听该属性的改变
// 在OC中是通过重写set方法
// 在swift中,可以给属性添加监听器
p.name = "Edwin"

// MARK: 类的构造函数
class Dog : NSObject {
    var name : String?  /**< 名字. */
    var age : Int = 0   /**< 狗龄. */
    var weight : Float = 0  /**< 体重. */
    
    /*! 重写初始化方法. */
    override init() {
        age = 3
    }
    init(name : String, age : Int, weight : Float) {
        self.name = name
        self.age = age
        self.weight = weight
    }
}

// 创建出来的person年龄自动为3
let dog = Dog.init()
print(dog.age)

let myDog = Dog.init(name: "黑子", age: 3, weight: 20.0)
print("名字：\(myDog.name!), 年龄：\(myDog.age), 体重：\(myDog.weight)")
