main() {
  var person = Person.age(12);
  print('menggod main: ${person.toString()}');
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
