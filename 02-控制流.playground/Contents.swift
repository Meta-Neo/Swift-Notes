//: Playground - noun: a place where people can play

import UIKit

// MARK: if的使用
/**
 if后面的()可以省略
 判断句不再有非0即真.必须有明确的Bool值:true/false
 */
let a = 89;
if a != 0 {
    print("a不等于0")
} else {
    print("a等于0")
}
// 检测API可用性
if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}

// MARK: if else 的使用
if a < 0 || a > 100 {
    print("数据无效")
} else if a < 60 {
    print("不及格")
} else if a < 80 {
    print("良好")
} else if a < 90 {
    print("优秀")
}
// MARK: 三目运算符
if a != 0 {
    print("a不等于0")
} else {
    print("a等于0")
}
// 上面的这个判断等效为
var ret = 0
ret = (a == 0) ? 0 : 1
// MARK: guard的使用
/**
 guard必须用在函数里，它与if语句非常类似，它设计的目的是提高程序的可读性
 具体使用见下例：
 模拟场景：一个学生想要上网，就要判断年龄
 */
let age = 20;
let withMoney : Bool = true;
let withID : Bool = false;
#if false
func online(age : Int) {
    if age >= 18 {
        if withID {
            if withMoney {
                print("您可以上网了")
            } else {
                print("回家拿钱吧你")
            }
        } else {
            print("请回家拿上身份证")
        }
    } else {
        print("未成年人不能上网")
    }
}
#else
/**
 guard语句必须带有else语句，
 如果条件成立跳过else{}中的内容，执行语句组内容
 如果条件不成立，则会执行else{}中的语句，跳转语句一般是return、break、continue和throw
 */
func online(age : Int) {
    // 1.判断年龄
    guard age >= 18 else {
        print("未成年人不能上网")
        return
    }
    // 2.判断是否带身份证
    guard withID else {
        print("上网必须要身份证"); return;
    }
    // 3.判断是否带钱
    guard withMoney else {
        print("上网不带钱么")
        return
    }
    print("客官，来上网啊")
}
#endif

// MARK: switch的使用
let sex = 0
switch sex {
case 0:
    print("男")
case 1:
    print("女")
default:
    print("其他")
}

/**
 switch可以不跟()
 case语句结束后可以不跟break，默认系统会加
 如果希望一个case中出现case穿透，那么可以在case语句结束后跟上fallthrough
 case后面可以跟多个条件,多个条件以,分割
 */
switch sex {
case 0, 1:
    print("正常人")
default:
    print("其他")
}
/// switch可以判断浮点型
let π = 3.14;
switch π {
case 3.14:
    print("π")
default:
    print("非π")
}
/// switch可以判断字符串
let m = 20
let n = 30
let opration = "+"

var ret1 = 0
switch opration {
case "+":
    ret1 = m + n
case "-":
    ret1 = m - n
case "*":
    ret1 = m * n
case "/":
    ret1 = m / n
default:
    print("非法操作符")
}
/// switch可以判断区间
let score = 93

switch score {
case 0..<60:
    print("不及格")
case 60..<80:
    print("及格")
case 80..<90:
    print("良好")
case 90...100:
    print("不错噢")
default:
    print("不合理的分数")
}

// MARK: for循环
for i in 0..<10 {
    print(i)
}

// 如果不需要用到下标值,可以使用_来代替
for _ in 0..<10 {
    print("hello world")
}

// MARK: while循环
/**
 while循环
 while后面的()可以省略
 没有非0(nil)即真
 */
var x = 10.0
while x > 0 {
    x -= 1
    print(x)
}
/**
 do while循环
 类型while循环的差别
 do需要换成repeat
 */
repeat {
    x += 1
    print(x)
} while x < 10

