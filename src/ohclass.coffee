###!
 * ohclass
 * https://github.com/elclanrs/ohclass
 * @author elclanrs
 * @license MIT
###

λ = (f) -> (as...) ->
  if as.length < f.length
    f.bind [null, as...]...
  else
    f as...

extend = (a, bs...) ->
  for b in bs
    for own k, v of b
      a[k] = v
  a

module.exports = λ (parent, obj) ->
  child = Object.create parent
  ctor = obj.new or (as...) -> @super as...
  extend obj,
    new: ->
      obj = Object.create this
      out = ctor.apply obj, arguments
      out ? obj
    instanceof: (ctor) ->
      ctor.isPrototypeOf this
  if parent
    return extend child, obj, super: ->
      extend this, parent.new.apply this, arguments
  obj
