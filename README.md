# ohclass

### Usage

Install:
```bash
> npm install ohclass
```

Require:
```javascript
var Class = require('ohclass')
```

Example:
```javascript
var Class = require('ohclass')

// Example 1
// ---------------------------------------------------

var Person = Class(null, {
  new: function(name, age) {
    this.name = name
    this.age = age
  },
  greet: function() {
    return 'Hello, my name is '+ this.name +'.'
  }
})

var Student = Class(Person, {
  new: function(name, age, grade) {
    this.super(name, age)
    this.grade = grade
  },
  greet: function() {
    return 'Hello, my grade is '+ this.grade +'.'
  }
})

var peter = Student.new('Peter', 25, 'A+')

console.log(peter.greet()) // Hello, my grade is A+
console.log(peter.instanceof(Student)) // true
console.log(peter.instanceof(Person)) // true

// Example 2
// ---------------------------------------------------

var Maybe = Class(null, {
  new: function(value) {
    if (value == null)
      return Nothing.new()
    return Just.new(value)
  },
  map: function(f) {
    return this.chain(function(x) {
      return this.new(f.call(this, x))
    })
  },
  chain: function(f) {
    if (this.instanceof(Just))
      return f.call(this, this.value)
    return Nothing.new()
  }
})

var Just = Class(Maybe, {
  new: function(value) {
    this.value = value
  }
})

var Nothing = Class(Maybe, {
  new: function() {
    this.value = null
  }
})

var result = Maybe.new(3).chain(function(x) {
  return Maybe.new(4).chain(function(y) {
    return this.new(x + y)
  })
})

console.log(result) // Just 7

var result = Maybe.new(3).chain(function(x) {
  return Maybe.new(null).map(function(y) {
    return x + y
  })
})

console.log(result) // Nothing
```

Builder:

```javascript
var mkVehicle = Class(Vehicle)

var Car = mkVehicle({
  new: function() {...}
})

var Boat = mkVehicle({
  new: function() {...}
})

var Bike = mkVehicle({
  new: function() {...}
})
```

Composable:

```javascript
var cars = ['Honda', 'Subaru', 'Ford'].map(Car.new)

var isAllCars = cars.every(Car.isPrototypeOf.bind(Car))

var apply = function(f) {
  return function() {
    return f.apply(null, arguments)
  }
}

var people = [['James', 25], ['Mike', 32]].map(apply(Person.new))
```

Mixins:

```javascript
var Walkable = {
  walk: function() {
    return 'Walking...'
  }
}

var Talkable = {
  talk: function() {
    return 'Talking...'
  }
}

// Mixin / Implements
// using ES6 object.assign (or Polyfill)
Object.assign(Person, Walkable, Talkable)
```
