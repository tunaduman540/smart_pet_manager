import 'package:flutter/material.dart';

// 🔹 Interface
abstract class Friendly {
  void beFriendly();
}

// 🔹 Mixin
mixin Flyable {
  void fly() {
    print("Flying high in the sky!");
  }
}

// 🔹 Abstract Base Class
abstract class Pet {
  static int petCount = 0; // static keyword example

  String name;
  int age;

  Pet(this.name, this.age) {
    petCount++;
  }

  Pet.named({required this.name, required this.age}) {
    petCount++;
  }

  void info() {
    print("Name: $name, Age: $age");
  }

  void makeSound(); // abstract method
}

// 🔹 Dog Class
class Dog extends Pet implements Friendly {
  String breed;

  Dog(String name, int age, this.breed) : super(name, age);

  @override
  void makeSound() {
    print("Woof! 🐶");
  }

  @override
  void beFriendly() {
    print("$name wags its tail happily!");
  }
}

// 🔹 Cat Class
class Cat extends Pet implements Friendly {
  String color;

  Cat(String name, int age, this.color) : super(name, age);

  @override
  void makeSound() {
    print("Meow! 🐱");
  }

  @override
  void beFriendly() {
    print("$name purrs softly!");
  }
}

// 🔹 Bird Class (with mixin)
class Bird extends Pet with Flyable implements Friendly {
  String species;

  Bird(String name, int age, this.species) : super(name, age);

  @override
  void makeSound() {
    print("Tweet! 🐦");
  }

  @override
  void beFriendly() {
    print("$name chirps happily!");
  }
}

void main() {
  runApp(MyApp());
}

// 🔹 Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Pet Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: PetHomePage(),
    );
  }
}

// 🔹 Stateful Widget
class PetHomePage extends StatefulWidget {
  @override
  State<PetHomePage> createState() => _PetHomePageState();
}

class _PetHomePageState extends State<PetHomePage> {
  final List<Pet> pets = [
    Dog("Buddy", 3, "Golden Retriever"),
    Cat("Luna", 2, "Gray"),
    Bird("Tweety", 1, "Canary"),
  ];

  String displayText = "Tap on a pet to see its behavior 🐾";

  void _showPetBehavior(Pet pet) {
    String text = "";

    pet.makeSound();
    if (pet is Dog) {
      text = "🐶 ${pet.name}: Woof! ${pet.name} wags its tail happily!";
    } else if (pet is Cat) {
      text = "🐱 ${pet.name}: Meow! ${pet.name} purrs softly!";
    } else if (pet is Bird) {
      text = "🐦 ${pet.name}: Tweet! ${pet.name} chirps happily and flies high!";
      pet.fly();
    }

    setState(() {
      displayText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Pet Manager"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Card(
                  color: pet is Dog
                      ? Colors.orange[100]
                      : pet is Cat
                      ? Colors.pink[100]
                      : Colors.lightBlue[100],
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(
                      pet is Dog
                          ? Icons.pets
                          : pet is Cat
                          ? Icons.pets_outlined
                          : Icons.air,
                      size: 40,
                    ),
                    title: Text(
                      pet.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Age: ${pet.age} - Type: ${pet.runtimeType}",
                    ),
                    onTap: () => _showPetBehavior(pet),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.teal[50],
            child: Column(
              children: [
                Text(
                  displayText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Pets: ${Pet.petCount}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
