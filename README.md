# surround-constructor
[![Build Status](https://travis-ci.org/zaboco/surround-constructor.png?branch=master)](https://travis-ci.org/zaboco/surround-constructor)

Adds surrounding hooks to a constructor

## Install

```sh
$ npm install surround-constructor [--save]
```

## Usage

### API

_LiveScript_:
```ls
require! \surround-constructor
SClass = surround-constructor SomeClass[, after: a_fn][, before: b_fn]
```

_Vanilla JS_
```js
surround-constructor = require('surround-constructor');
SClass = surround-constructor(SomeClass) // does nothing
SClass = surround-constructor(SomeClass, { before: do_before_fn });
SClass = surround-constructor(SomeClass, { after: do_after_fn });
SClass = surround-constructor(SomeClass, { before: b_fn, after: a_fn });
```

All the callbacks calls get the constructor arguments

### Examples

#### Basic Usage
```ls
require! \surround-constructor

class SomeClass
  -> console.log '--- original constructor'

SurroundedClass = surround-constructor SomeClass,
  before: -> console.log 'vvv before constructor'
  after: -> console.log '^^^ after constructor'

new SurroundedClass
# vvv before constructor
# --- original constructor
# ^^^ after constructor
```

#### Class extension: logging
```ls
logging = (klass) ->
  surround-constructor klass, after: (...args)->
    console.log "#{klass.name} constructor called with #args"

SomeClass = logging class SomeClass
  (@v=0) -> console.log "constructor called with #v"

new SomeClass 1
# constructor called with 1
# SomeClass constructor called with 1
```
