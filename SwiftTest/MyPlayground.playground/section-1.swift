// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let test = 1

println(test)

for(var i=0; i<10; i++){
    println(i)
}
    


func indexOf(array:[String], value: String) -> Int? {
    for (index, str) in enumerate(array) {
        if str == value {
            return index
        }
    }
    return nil
}

let fruits = ["apple", "orange", "grape"]

if let index = indexOf(fruits, "peach") {
    println("peach は\(index)番目に存在します")
} else {
    println("存在しません")
}