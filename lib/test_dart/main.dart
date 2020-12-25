main() {
  var person = Person.age(12);
  print(person);
}

class Person {
  int age;
  String name;

  Person(this.age, this.name);

  Person.age(this.age);

  @override
  String toString() {
    return 'Person{age: $age, name: $name}';
  }
}
