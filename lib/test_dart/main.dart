import 'dart:io';

main() {
  // var person = Person.age(12);
  // print('menggod main: ${person.toString()}');

  testCatch();
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
