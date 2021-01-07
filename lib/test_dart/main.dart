import 'dart:io';

import 'package:flutter_code_test/api/api.dart';

main() {
  // var person = Person.age(12);
  // print('menggod main: ${person.toString()}');

  // testCatch();
  // var a = A(20, "haha");
  //
  // var b = B(30, "heihei");
  var dateTime = DateTime.now();
  var month = dateTime.month;
  var day = dateTime.day;
  String num = "$month-$day";
  String num1 = "$month-$day";
  print(null==num1);
}

void testCatch() async {
  var dir = new Directory('/tmp11111');
  var dirList = dir.list();
  await for (FileSystemEntity f in dirList) {
    if (f is File) {
      print('Found file ${f.path}');
    } else if (f is Directory) {
      print('Found dir ${f.path}');
    }
  }
}

class A extends Person {
  A(int age, String name) : super(age, name);
}

class B extends Person {
  B(int age, String name) : super(age, name);
}

class C {
  A a;
  B b;

  C({A a, B b});
}

class Person {
  int age;
  String name;
  var test = 3333;

  Person(this.age, this.name);

  Person.age(this.age) {
    print('menggod test:$test ');
  }

  @override
  String toString() {
    return 'Person{age: $age, name: $name}';
  }
}

class Singleton {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance {
    return _instance;
  }
}
