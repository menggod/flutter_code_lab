import 'dart:io';


var a = A(20, "haha");

main() {
  // var person = Person.age(12);
  // print('menggod main: ${person.toString()}');

  // testCatch();
  //  a = A(20, "haha");
  // a.age = 30;
  // print('menggod main: ${a.hashCode}');
  // // a = A(20, "haha");
  // a.age = 30;
  // print('menggod main: ${a.hashCode}');

  // var a = Node("haha");
  // print('menggod main: ${a.hashCode}');
  // a = Node("hehe");
  // print('menggod main: ${a.hashCode}');
  //
  // var b = B(30, "heihei");
  // var dateTime = DateTime.now();
  // var month = dateTime.month;
  // var day = dateTime.day;
  // String num = "$month-$day";
  // String num1 = "$month-$day";
  // print(null==num1);

  // var list = [1, 2, 3, 4, 5, 56, 6, 7, 8, 9];
  // list.map((e) => print('menggod main map:$e '));
  //
  // list.forEach((element) {print('menggod main forEach: $element');});



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

class Node {
  String name;
  int age;

  factory Node(String name) {
    return Node._a(name, 1);
  }

  Node._a(this.name, this.age);
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

  Person(this.age, this.name) {
    print('menggod 1111--> {age: $age, name: $name}');
  }

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
