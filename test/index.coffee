assert = require('assert').deepEqual
Class = require '../src/ohclass.coffee'

test = (name, result, expected) ->
  assert result, expected, "#{name}: expected #{JSON.stringify expected} but got #{JSON.stringify result}"
  console.log "#{name} ✓"

Person = Class null,
  new: (@name, @age) ->
  greet: -> "Hello, my name is #{@name}"
  run: -> 'Running'

Student = Class Person,
  new: (name, age, @grade) ->
    @super name, age
  greet: -> "Hello, my grade is #{@grade}"

josh = Person.new 'Josh', 32
peter = Student.new 'Peter', 25, 'A+'

test 'is an object', peter, {name: 'Peter', age: 25, grade: 'A+'}
test 'is an instance', peter.instanceof(Student), true
test 'is an instance of parent', peter.instanceof(Person), true
test 'inherits methods', typeof peter.run, 'function'
test 'polymorphism (1)', josh.greet(), 'Hello, my name is Josh'
test 'polymorphism (2)', peter.greet(), 'Hello, my grade is A+'

console.log '\nAll good!'
