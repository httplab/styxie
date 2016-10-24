@Styxie ?= {}

@Styxie.Initializers = {}
@Styxie.initQueue ?= []

@Styxie.applyInitializer = (klass, method, json) ->
  initializer = @Initializers[klass]
  return unless initializer

  if initializer.initialize
    initializer.initialize(json)

  if initializer[method]
    initializer[method](json)

@Styxie.deferredInit = ->
  @applyInitializer.apply(this, args) for args in @initQueue
  @initQueue = []

@initStyxie = =>
  @Styxie.deferredInit()
