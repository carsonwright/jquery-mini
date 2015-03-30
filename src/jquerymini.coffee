jQueryMini = (selector)->
  item = document.querySelectorAll(selector)
  fn = (i)->
      i.first =->
        fn(@[0])
      i.last =->
        fn(@[@.length - 1])
      i.html = (html)->
          if html?
            if @length?
              for node in this
                node.innerHTML = html
            else
              this.innerHTML = html
            this
          else
            if @length?
              @first().innerHTML
            else
              @innerHTML
      i.attr =  (attrName, attrValue)->
          if attrValue?
            @first().setAttribute(attrName, attrValue)
            this
          else
            @first().getAttribute(attrName)
      i.append = (target)->
        if @length?
          @first().appendChild(target)
        else
          @appendChild(target)
        this
      i.prepend = (target)->
        if @length?
          @first().insertBefore(target, @firstChild)
        else
          @insertBefore(target, @firstChild)
        this
      i.addClass = (className)->
        if @length?
          for node in @
            node.className += className
        else
          @className += className
        this
      i.removeClass = (className)->
        if @length?
          for node in  @
            node.className = node.className.replace(className, "")
        else
          @className = @className.replace(className, "")
        this
      i.hasClass = (className)->
        @className.split(" ").indexOf(className) != -1
      i.unbind = (target)->
        eventListeners = jQueryMini.eventListeners
        removeEvents = (node)->
          removeEvent = (handler, event)->
            if node.removeEventListener?
              node.removeEventListener(handler, event)
            else
              node.detachEvent(handler, event)

          if target?
            for event in eventListeners[node][target]
              removeEvent(target, event)
              eventListeners[node][target] = Array()
          else
            for target in Object.keys(eventListeners[node])
              for event in eventListeners[node][target]
                removeEvent(target, event)

            eventListeners[node] = Object()

        if @length?
          for node in this
            removeEvents(node)
        else
          removeEvents(this)
        jQueryMini.eventListeners = eventListeners

      event = (target, handler, callback)->
        jQueryMini.eventListeners[target] ?= Object()
        jQueryMini.eventListeners[target][handler] ?= Array()
        jQueryMini.eventListeners[target][handler].push(callback)
        if target.addEventListener?
          target.addEventListener(handler, callback)
        else if target.attachEvent?
          target.attachEvent(handler, callback)
      i.click = (callback)->
        if @length?
          for node in this
            event(node, "click", callback)
        else
          event(node, "click", callback)
      i.on = (handler, target, callBack)->
          if @length
            localNode = @first()
          else
            localNode = this

          event(localNode, handler, (e)->
            targetList = document.querySelectorAll(target)
            targetList = Array.prototype.slice.call(targetList)
            if targetList.indexOf(e.target) != -1
              callBack(e.target)
          )

      i
  fn(item)

jQueryMini.eventListeners = Object()
