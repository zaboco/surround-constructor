
module.exports = (klass, {before=->, after=->} = {}) ->
  old-proto = klass::
  klass = !->
    before ...
    old-proto.constructor ...
    after ...
  klass:: = old-proto
  klass
