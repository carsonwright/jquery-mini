var jQueryMini;

jQueryMini = function(selector) {
  var fn, item;
  item = document.querySelectorAll(selector);
  fn = function(i) {
    var event;
    i.first = function() {
      return fn(this[0]);
    };
    i.last = function() {
      return fn(this[this.length - 1]);
    };
    i.html = function(html) {
      var j, len, node;
      if (html != null) {
        if (this.length != null) {
          for (j = 0, len = this.length; j < len; j++) {
            node = this[j];
            node.innerHTML = html;
          }
        } else {
          this.innerHTML = html;
        }
        return this;
      } else {
        if (this.length != null) {
          return this.first().innerHTML;
        } else {
          return this.innerHTML;
        }
      }
    };
    i.attr = function(attrName, attrValue) {
      if (attrValue != null) {
        this.first().setAttribute(attrName, attrValue);
        return this;
      } else {
        return this.first().getAttribute(attrName);
      }
    };
    i.append = function(target) {
      if (this.length != null) {
        this.first().appendChild(target);
      } else {
        this.appendChild(target);
      }
      return this;
    };
    i.prepend = function(target) {
      if (this.length != null) {
        this.first().insertBefore(target, this.firstChild);
      } else {
        this.insertBefore(target, this.firstChild);
      }
      return this;
    };
    i.addClass = function(className) {
      var j, len, node;
      if (this.length != null) {
        for (j = 0, len = this.length; j < len; j++) {
          node = this[j];
          node.className += className;
        }
      } else {
        this.className += className;
      }
      return this;
    };
    i.removeClass = function(className) {
      var j, len, node;
      if (this.length != null) {
        for (j = 0, len = this.length; j < len; j++) {
          node = this[j];
          node.className = node.className.replace(className, "");
        }
      } else {
        this.className = this.className.replace(className, "");
      }
      return this;
    };
    i.hasClass = function(className) {
      return this.className.split(" ").indexOf(className) !== -1;
    };
    i.unbind = function(target) {
      var eventListeners, j, len, node, removeEvents;
      eventListeners = jQueryMini.eventListeners;
      removeEvents = function(node) {
        var event, j, k, l, len, len1, len2, ref, ref1, ref2, removeEvent, results;
        removeEvent = function(handler, event) {
          console.log(handler);
          console.log(event);
          if (node.removeEventListener != null) {
            return node.removeEventListener(handler, event);
          } else {
            return node.detachEvent(handler, event);
          }
        };
        if (target != null) {
          ref = eventListeners[node][target];
          results = [];
          for (j = 0, len = ref.length; j < len; j++) {
            event = ref[j];
            removeEvent(target, event);
            results.push(eventListeners[node][target] = Array());
          }
          return results;
        } else {
          ref1 = Object.keys(eventListeners[node]);
          for (k = 0, len1 = ref1.length; k < len1; k++) {
            target = ref1[k];
            ref2 = eventListeners[node][target];
            for (l = 0, len2 = ref2.length; l < len2; l++) {
              event = ref2[l];
              removeEvent(target, event);
            }
          }
          return eventListeners[node][target] = Array();
        }
      };
      if (this.length != null) {
        for (j = 0, len = this.length; j < len; j++) {
          node = this[j];
          console.log("trigger?");
          removeEvents(node);
        }
      } else {
        removeEvents(this);
      }
      return jQueryMini.eventListeners = eventListeners;
    };
    event = function(target, handler, callback) {
      var base, base1;
      if ((base = jQueryMini.eventListeners)[target] == null) {
        base[target] = Object();
      }
      if ((base1 = jQueryMini.eventListeners[target])[handler] == null) {
        base1[handler] = Array();
      }
      jQueryMini.eventListeners[target][handler].push(callback);
      if (target.addEventListener != null) {
        return target.addEventListener(handler, callback);
      } else if (target.attachEvent != null) {
        return target.attachEvent(handler, callback);
      }
    };
    i.click = function(callback) {
      var j, len, node, results;
      if (this.length != null) {
        results = [];
        for (j = 0, len = this.length; j < len; j++) {
          node = this[j];
          results.push(event(node, "click", callback));
        }
        return results;
      } else {
        return event(node, "click", callback);
      }
    };
    i.on = function(handler, target, callBack) {
      var localNode;
      if (this.length) {
        localNode = this.first();
      } else {
        localNode = this;
      }
      return event(localNode, handler, function(e) {
        var targetList;
        targetList = document.querySelectorAll(target);
        targetList = Array.prototype.slice.call(targetList);
        if (targetList.indexOf(e.target) !== -1) {
          return callBack(e.target);
        }
      });
    };
    return i;
  };
  return fn(item);
};

jQueryMini.eventListeners = Object();
