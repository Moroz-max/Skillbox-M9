import UIKit

class Animal {
    private var energy: Int
    private var weight: Int
    private var currentAge: Int
    private var maxAge: Int
    var name: String
    var isTooOld: Bool {
        if currentAge >= maxAge{
            return true
        } else {
            return false
        }
    }
    
    init(energy: Int, weight: Int, maxAge: Int, name: String, currentAge: Int) {
        self.energy = energy
        self.weight = weight
        self.maxAge = maxAge
        self.name = name
        self.currentAge = currentAge
    }
        
    public func sleep (){
        if !isTooOld {
            energy += 5
            currentAge += 1
            print("\(name) спит")
        }
    }
    public func eating () {
        if !isTooOld {
        energy += 3
        weight += 1
        tryIncrementAge()
        print("\(name) ест")
        }
    }
    public func moving () {
        if (energy - 5) >= 0 && (weight - 1) >= 0 && !isTooOld {
            energy -= 5
            weight -= 1
            tryIncrementAge()
            print("\(name) передвигается")
        }
    }
    public func reproduction () -> Animal {
        let newName = self.name
        let newMaxAge = self.maxAge
        let newEnergy = Int.random(in: 1...10)
        let newWeigt = Int.random(in: 1...5)
        
        let newAnimal = Animal(energy: newEnergy, weight: newWeigt, maxAge: newMaxAge, name: newName, currentAge: 0)
        print("Рожден \(newAnimal.name). Энергия \(newAnimal.energy), вес \(newAnimal.weight), максимальный возраст \(newAnimal.maxAge)")
        
        
        return newAnimal
        
}
    
    private func tryIncrementAge() {
        if Bool.random() {
            currentAge += 1
        }
    }
    
}

class Bird: Animal {
    override func moving() {
        super.moving()
        Animal.moving(self)
        print("Летит")
    }
    override func reproduction() -> Bird {
        super.reproduction()
        return self
    }
}

class Dog: Animal {
    override func moving() {
        super.moving()
        Animal.moving(self)
        print("Бежит")
    }
    override func reproduction() -> Dog {
        super.reproduction()
        return self
    }
    
}

class Fish: Animal {
    override func moving() {
        super.moving()
        Animal.moving(self)
        print("Плывет")
    }
    override func reproduction() -> Fish {
        super.reproduction()
        return self
    }
}

class NatureReserve {
    
    var array = [Animal]()
    
    init(animals: [Animal]) {
        self.array = animals
    }
    func generateRandomAction() {
        for animal in array {
            let randomSelection = Int.random(in:0...3)
            
            switch randomSelection {
            case 0: animal.sleep()
            case 1: animal.moving()
            case 2: animal.eating()
            case 3: animal.reproduction(); array.append(animal)
            default: animal.sleep()
            }
        }
        
    }
    func start() {
        for _ in 1...15 {
            if array.isEmpty == false {
                self.generateRandomAction()
                var notDeadArray: [Animal] = []
                for animal in array {
                    if animal.isTooOld == false {
                        notDeadArray.append(animal)}
                    else {
                        print ("\(animal.name) умирает")

                    }
                }
                array = notDeadArray
            }
        }
        if array.isEmpty {
            print("Заповедник пуст")
        } else {
            print ("Количество животных в заповеднике - \(array.count)")
        }
    }
    
  }

//-------------------------------------------------------------------

var allAnimals = [Animal]()

for num in 1...20 {
    allAnimals.append(Bird(energy: Int.random(in: 1...125), weight: Int.random(in: 1...30), maxAge: Int.random(in: 20...50), name: "Bird\(num)", currentAge: Int.random(in: 1...15)))
}

for num in 1...15 {
    allAnimals.append(Dog(energy: Int.random(in: 1...200), weight: Int.random(in: 1...70), maxAge: Int.random(in: 30...100), name: "Dog\(num)", currentAge: Int.random(in: 1...25)))
}

for num in 1...30 {
    allAnimals.append(Fish(energy: Int.random(in: 1...100), weight: Int.random(in: 1...50), maxAge: Int.random(in: 40...70), name: "Fish\(num)", currentAge: Int.random(in: 1...25)))
}
for num in 1...2 {
    allAnimals.append(Animal(energy: Int.random(in: 1...100), weight: Int.random(in: 1...60), maxAge: Int.random(in: 40...60), name: "Animal\(num)", currentAge: Int.random(in: 1...15)))
}



var game = NatureReserve(animals: allAnimals)
game.start()
