if ("undefined" == typeof jQuery) throw new Error("Bootstrap's JavaScript requires jQuery"); +
function(t) {
    "use strict";
    var e = t.fn.jquery.split(" ")[0].split(".");
    if (e[0] < 2 && e[1] < 9 || 1 == e[0] && 9 == e[1] && e[2] < 1 || e[0] > 3) throw new Error("Bootstrap's JavaScripap's JavaScript requires jQuery version 1.9.1 or higher, but lower than version 4")
} (jQuery),

+
function(t) {
    "use strict";
    function e(s, i) {
        this.$body = t(document.body)
        this.$scrollElement = t(t(s).is(document.body) ? window: s)
        this.options = t.extend({},e.DEFAULTS, i)
        this.selector = (this.options.target || "") + " .nav li > a"
        this.offsets = []
        this.targets = []
        this.activeTarget = null
        this.scrollHeight = 0
        this.$scrollElement.on("scroll.bs.scrollspy", t.proxy(this.process, this))
        this.refresh()
        this.process()
    }
    function s(s) {
        return this.each(function() {
            var i = t(this),
            o = i.data("bs.scrollspy"),
            r = "object" == typeof s && s;
            o || i.data("bs.scrollspy", o = new e(this, r)),
            "string" == typeof s && o[s]()
        })
    }
    e.VERSION = "3.3.7",
    e.DEFAULTS = {
        offset: 10
    },
    e.prototype.getScrollHeight = function() {
        return this.$scrollElement[0].scrollHeight || Math.max(this.$body[0].scrollHeight, document.documentElement.scrollHeight)
    },
    e.prototype.refresh = function() {
        var e = this,
        s = "offset",
        i = 0;
        this.offsets = [],
        this.targets = [],
        this.scrollHeight = this.getScrollHeight(),
        t.isWindow(this.$scrollElement[0]) || (s = "position", i = this.$scrollElement.scrollTop()),
        this.$body.find(this.selector).map(function() {
            var e = t(this),
            o = e.data("target") || e.attr("href"),
            r = /^#./.test(o) && t(o);
            return r && r.length && r.is(":visible") && [[r[s]().top + i, o]] || null
        }).sort(function(t, e) {
            return t[0] - e[0]
        }).each(function() {
            e.offsets.push(this[0]),
            e.targets.push(this[1])
        })
    },
    e.prototype.process = function() {
        var t, e = this.$scrollElement.scrollTop() + this.options.offset,
        s = this.getScrollHeight(),
        i = this.options.offset + s - this.$scrollElement.height(),
        o = this.offsets,
        r = this.targets,
        n = this.activeTarget;
        if (this.scrollHeight != s && this.refresh(), e >= i) return n != (t = r[r.length - 1]) && this.activate(t);
        if (n && e < o[0]) return this.activeTarget = null,
        this.clear();
        for (t = o.length; t--;) n != r[t] && e >= o[t] && (void 0 === o[t + 1] || e < o[t + 1]) && this.activate(r[t])
    },
    e.prototype.activate = function(e) {
        this.activeTarget = e,
        this.clear();
        var s = this.selector + '[data-target="' + e + '"],' + this.selector + '[href="' + e + '"]',
        i = t(s).parents("li").addClass("active");
        i.parent(".dropdown-menu").length && (i = i.closest("li.dropdown").addClass("active")),
        i.trigger("activate.bs.scrollspy")
    },
    e.prototype.clear = function() {
        t(this.selector).parentsUntil(this.options.target, ".active").removeClass("active")
    };
    var i = t.fn.scrollspy;
    t.fn.scrollspy = s,
    t.fn.scrollspy.Constructor = e,
    t.fn.scrollspy.noConflict = function() {
        return t.fn.scrollspy = i,
        this
    },
    t(window).on("load.bs.scrollspy.data-api",
    function() {
        t('[data-spy="scroll"]').each(function() {
            var e = t(this);
            s.call(e, e.data())
        })
    })
} (jQuery);

$(function() {
    var t = $("#toc");
    if (!t.length || t.is(":hidden")) return;
    var e = t.children(),
    s,
    i = $(".post-content"),
    o;
    function r() {
        var r = i.position().top + i.outerHeight(),
        n = t.height();
        o = r - n;
        s = e.height()
    }
    r();
    e.addClass("nav");
    $(window).resize(r);
    $("body").scrollspy({
        target: "#toc",
        offset: 40
    });
    $(window).scroll(function() {
        var e = $(window).scrollTop();
        var s;
        if (e < 141) s = 165 - e;
        else if (o > e) s = 25;
        else s = o - e;
        t.css("top", s)
    });
    $(".toc-item").on("activate.bs.scrollspy",
    function() {
        var t = e.scrollTop(),
        i = $(this).children(".toc-link"),
        o = i.position().top;
        // if ($(this).height() != i.height()) return;
        // if (o <= 0) e.scrollTop(t + o);
        // else if (s <= o) e.scrollTop(t + o + i.outerHeight() - s)
    })
});