class window.LayersController


  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->
    @preloadedView = new steroids.views.WebView
      id: 'pop_preloaded',
      location:"/views/layers/pop.html"

    @preloadedView.preload()


  # Make Navigation Bar to appear with a custom title text
  unless window.location.href.match("pop.html")
    steroids.navigationBar.show { title: "layers" }

  @createWebView: ->
    new steroids.views.WebView {
      location: "/views/layers/pop.html"
    }

  @testPreloadedCommandCenter2: ->

    commandCenter = new steroids.views.WebView "/views/layers/preloadedCommandCenter2.html"

    commandCenter.preload({}, {
      onSuccess: ->
        steroids.logger.log "SUCCESS in preloading the command center"
      onFailure: ->
        steroids.logger.log "FAILURE in preloading the command center"
        navigator.notification.alert "FAILURE in preloading the command center"
    })

  @testPreloadedCommandCenter: ->

    commandCenter = new steroids.views.WebView "/views/layers/preloadedCommandCenter.html"

    commandCenter.preload({}, {
      onSuccess: ->
        steroids.logger.log "SUCCESS in preloading the command center"
      onFailure: ->
        steroids.logger.log "FAILURE in preloading the command center"
        navigator.notification.alert "FAILURE in preloading the command center"
    })

  @testPushPreloaded: ->

    success = ->
      steroids.logger.log "SUCCESS in pushing pop.html preloaded"
    failure = ->
      steroids.logger.log "FAILURE in testPushPreloaded"

    steroids.layers.push
      view:
        id: 'pop_preloaded'
    ,
      onSuccess: success
      onFailure: failure

  @testShowNavBar: ->
    steroids.navigationBar.show "layers!",
      onSuccess: -> steroids.logger.log "SUCCESS in showing navigation bar"
      onFailure: ->
        steroids.logger.log "FAILURE in testShowNavBar"
        navigator.notification.alert "FAILURE in testShowNavBar"

  @testPushPop: ->
    success = ->
      steroids.logger.log "SUCCESS in pushing pop.html"
    failure = ->
      steroids.logger.log "FAILURE in testPushPop"
      navigator.notification.alert "FAILURE in testPushPop"

    steroids.layers.push {
      view: @createWebView()
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testPop: ->
    success = ->
      steroids.logger.log "SUCCESS in popping the topmost layer"
    failure = ->
      steroids.logger.log "FAILURE in testPop"
      navigator.notification.alert "FAILURE in testPop"

    steroids.layers.pop({}, {
      onSuccess: success
      onFailure: failure
    })

  @testPushAnimated: ->
    animation = new steroids.Animation {
      transition: "flipVerticalFromTop",
      duration: 1.2,
      curve: "linear"
    }


    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS push with animation"
      onFailure: ->
        steroids.logger.log "FAILURE in testPushAnimated"
        navigator.notification.alert "FAILURE in testPushAnimated"
    }

  @testPushHideNavBar: ->
    steroids.layers.push {
      view: @createWebView(),
      navigationBar: false
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer while hiding nav bar"
      onFailure: ->
        steroids.logger.log "FAILURE in testPushHideNavBar"
        navigator.notification.alert "FAILURE in testPushHideNavBar"
    }

  @testPushHideTabBar: ->
    steroids.layers.push {
      view: @createWebView(),
      tabBar: false
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer while hiding tab bar"
      onFailure: ->
        steroids.logger.log "FAILURE in testPushHideTabBar"
        navigator.notification.alert "FAILURE in testPushHideTabBar"
    }

  @testKeepLoading: ->
    keepLoadingView = new steroids.views.WebView "/views/layers/keepLoading.html"

    steroids.layers.push {
      view: keepLoadingView
      keepLoading: true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer while keeping loading screen until non-preloaded view is loaded and result view removes the loading.html/png"
      onFailure: ->
        steroids.logger.log "FAILURE in testKeepLoading"
        navigator.notification.alert "FAILURE in testKeepLoading"
    }

  @testKeepLoadingWithPreloaded: ->
    pushPreloadedWebViewWithKeep = =>
      steroids.layers.push {
        view: keepLoadingView
        keepLoading: true
      }, {
        onSuccess: -> steroids.logger.log "SUCCESS in pushing preloaded web view while keeping loading screen until preloaded view removes it"
        onFailure: ->
          steroids.logger.log "FAILURE in testKeepLoadingWithPreloaded"
          navigator.notification.alert "FAILURE in testKeepLoadingWithPreloaded"
      }

    keepLoadingView = new steroids.views.WebView "/views/layers/keepLoading.html"

    keepLoadingView.preload({}, {
      onSuccess: pushPreloadedWebViewWithKeep
      onFailure: ->
        steroids.logger.log "FAILURE in preloading view in testKeepLoadingWithPreloaded"
        navigator.notification.alert "FAILURE in preloading view in testKeepLoadingWithPreloaded"
    })

  @testPushAnimatedSlideFromLeftAndFade: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer with slideFromLeft and Fade animation"
      onFailure: ->
        steroids.logger.log "FAILURE in testPushAnimatedSlideFromLeftAndFade"
        navigator.notification.alert "FAILURE in testPushAnimatedSlideFromLeftAndFade"
    }

  @testPushAnimatedSlideFromLeftAndFadeFast: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"
      duration: 0.1

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer with slideFromLeft and FadeFast animation"
      onFailure: ->
        steroids.logger.log "FAILURE in testPushAnimatedSlideFromLeftAndFadeFast"
        navigator.notification.alert "FAILURE in testPushAnimatedSlideFromLeftAndFadeFast"
    }

  @testPushAnimatedSlideFromLeftAndFadeFastAndSlow: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"
      duration: 0.1
      reversedDuration: 2.5

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer with slideFromLeft and FadeFastAndSlow animation"
      onFailure: ->
        steroids.logger.log "FAILURE in testPushAnimatedSlideFromLeftAndFadeFastAndSlow"
        navigator.notification.alert "FAILURE in testPushAnimatedSlideFromLeftAndFadeFastAndSlow"
    }

  @testKeepLoadingThis: ->

    removeLoading = () ->
      setTimeout ( ->
        steroids.view.removeLoading()
      ), 2000

    keepLoadingView = new steroids.views.WebView "/views/layers/pop.html"

    steroids.layers.push {
      view: keepLoadingView
      keepLoading: true
    }, {
      onSuccess: ->
        removeLoading
        steroids.logger.log "SUCCESS in pushing layer while keeping loading.html/png on top, this view should remove loading html after timeout"
      onFailure: ->
        steroids.logger.log "FAILURE in testKeepLoadingThis"
        navigator.notification.alert "FAILURE in testKeepLoadingThis"
    }

  @testReplace: ->
    view = new steroids.views.WebView "/views/layers/index.html"
    view.preload {},
      onSuccess: =>
        steroids.layers.replace(
          {
            view: view
          }, {
            onSuccess: ->
              steroids.logger.log "SUCCESS in replacing with a preloaded layer"
            onFailure: ->
              steroids.logger.log "FAILURE in testReplace while replacing view with preloaded layer"
              navigator.notification.alert "FAILURE in testReplace while replacing view with preloaded layer"
          })
      onFailure: ->
        steroids.logger.log "FAILURE in testReplace while preloading view"
        navigator.notification.alert "FAILURE in testReplace with preloading view"


  @testReplaceToRoot: ->
    rootView = new steroids.views.WebView {
      location: "/views/layers/index.html"
      id: "http://localhost/views/steroids/index.html"
    }

    steroids.layers.replace(
      {
        view: rootView
      }, {
        onSuccess: ->
          steroids.logger.log "SUCCESS in replacing view to root without preload"
        onFailure: ->
          steroids.logger.log "FAILURE in testReplaceToRoot"
          navigator.notification.alert "FAILURE in testReplaceToRoot"
      }
    )

  @testReplaceViaPreloadedView: ->
    msg = {commandToPreloadedView: "testReplaceToRoot"}
    window.postMessage msg, '*'

  @testAlertViaPreloadedView: ->
    msg = {commandToPreloadedView: "testAlert"}
    window.postMessage msg, '*'

  @testInvalidLayerEvents: ->
    try
      steroids.layers.on 'invalidEventName', (event) ->
        steroids.logger.log "TEST FAILURE in testInvalidLayerEvents - was able to add event listener with invalid name"
        navigator.notification.alert "TEST FAILURE in testInvalidLayerEvents - was able to add event listener with invalid name"
    catch error
      steroids.logger.log "TEST SUCCESS steroids.layers.on was called with invalid layer event but this was catched. Error catched: '#{error}'"

  @didChangeHandlers = []
  @willChangeHandlers = []

  @testwillchangeEvent: ->
    eventHandler = steroids.layers.on 'willchange', (event) ->
      targetId = if event.target? and event.target.webview.id?
        event.target.webview.id
      else
        ""
      sourceId = if event.source? and event.source.webview.id?
        event.source.webview.id
      else
        ""

      navigator.notification.alert "willchange event -> eventName: #{event.name} target.webview.id: #{targetId} source.webview.id: #{sourceId}"

    @willChangeHandlers.push eventHandler

    steroids.logger.log "event listener for layers WILL CHANGE added"

  @testdidchangeEvent: ->
    eventHandler = steroids.layers.on 'didchange', (event) ->
      targetId = if event.target? and event.target.webview.id?
        event.target.webview.id
      else
        ""
      sourceId = if event.source? and event.source.webview.id?
        event.source.webview.id
      else
        ""
      navigator.notification.alert "didchange event -> eventName: #{event.name} target.webview.id: #{targetId} source.webview.id: #{sourceId}"

    @didChangeHandlers.push eventHandler

    steroids.logger.log "event listener for layers DID CHANGE added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.layers.off 'didchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.layers.off 'willchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    steroids.logger.log "event handlers for layers change removed"

  @testRemovedidchangeEvents: ->
    steroids.layers.off 'didchange'

    steroids.logger.log "didchange events handlers removed"

  @testRemovewillchangeEvents: ->
    steroids.layers.off 'willchange'

    steroids.logger.log "willchange events handlers removed"

  @testAnotherLayer: ->
    success = ->
      steroids.logger.log "SUCCESS in pushing another layer"
    failure = ->
      steroids.logger.log "FAILURE in testAnotherLayer"

    steroids.layers.push {
      view: @createWebView()
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testPopAll: ->
    steroids.layers.popAll {}
    ,
      onTransitionStarted: ->
        steroids.logger.log "steroids.layers.popAll invoked, waiting for finished..."
      onTransitionEnd: ->
        steroids.logger.log "SUCCESS steroids.layers.popAll finished"

  @testReplaceNonPreloaded: ->
    view = new steroids.views.WebView "/views/layers/index.html"
    steroids.layers.replace {
        view: view
      }, {
        onSuccess: -> steroids.logger.log "SUCCESS in replacing a non-preloaded webview to the layer stack"
        onFailure: -> navigator.notification.alert "FAILURE in testReplaceNonPreloaded"
      }
  @testReplaceStep1: ->
    view = new steroids.views.WebView
      location: "/views/layers/replaceStep1.html"
      id: "preloadedStep1"

    view.preload {}
    ,
      onSuccess: ->
        steroids.layers.push
          view: view
      onFailure:->
        # if it fails to preload .. because it is already preloaded..
        # not problem,.. we push anyway
        steroids.layers.push
          view: view

  @testReplaceStep2: ->
    steroids.layers.push
      view: new steroids.views.WebView "/views/layers/replaceStep2.html"

  @testReplaceWithViewAlreadyInStack: ->
    view = new steroids.views.WebView
      location: "/views/layers/replaceStep1.html"
      id: "preloadedStep1"

    steroids.layers.replace
      view: view
    ,
      onSuccess: ->
        alert "SUCCESS in replacing a webview that was already in the stack!"
      onFailure: ->
        alert "FAILURE in testReplaceWithViewAlreadyInStack"
