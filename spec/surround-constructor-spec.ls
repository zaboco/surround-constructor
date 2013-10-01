require! {
  '../src/surround-constructor'
  \sinon
}
expect = require \chai .use (require \sinon-chai) .expect

that = it

var SKlass, TmpKlass

class Klass
SOME_VALUE = 1

hooks =
  before: ->
  after: ->

spies =
  constructor: sinon.spy Klass::, 'constructor'
  before: sinon.spy hooks, \before
  after: sinon.spy hooks, \after

reset-spies = ->
  spies.constructor.reset!
  spies.before.reset!
  spies.after.reset!

hook-suite = (position) -> ->
  before-each ->
    SKlass := surround-constructor Klass, "#position": hooks[position]
    new SKlass SOME_VALUE
  that 'constructor is still called (once)' ->
    expect spies.constructor .to.be.called-once
  that "#position hook is called once" ->
    expect spies[position] .to.be.called-once
  that "#position hook is called with constructor args" ->
    expect spies[position] .to.be.called-with SOME_VALUE
  that "#position hook is called #position constructor" ->
    expected-call-check = switch position
      | \after => 'calledAfter'
      | \before => 'calledBefore'
    expect spies[position] .to.be[expected-call-check] spies.constructor

describe \surround-constructor ->
  before-each reset-spies
  describe 'class variable are kept' ->
    before-each ->
      SKlass := surround-constructor class _TmpKlass
        @value = 1
      TmpKlass := _TmpKlass
    that 'in original class' ->
      expect TmpKlass.value .to.eql 1
    that 'in surrounding class' ->
      expect SKlass.value .to.eql 1
  describe 'w/ no hooks' ->
    before-each ->
      SKlass := surround-constructor Klass
    that 'constructor is still called (once)' ->
      new SKlass
      expect spies.constructor .to.be.called-once
    that 'constructor is called with original args' ->
      new SKlass SOME_VALUE
      expect spies.constructor .to.be.called-with SOME_VALUE
  describe 'w/ before hook' hook-suite \before
  describe 'w/ after hook' hook-suite \after
