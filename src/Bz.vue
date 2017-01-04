<template>
  <div></div>
</template>

<script>
  import $ from 'jquery'

  export default {
    data: function () {
      return {
        is_visible: false,
        is_first: true
      }
    },
    mounted: function () {
      let outerHeight = $('body .container').outerHeight()
      let windowHeight = $(window).height()

      if (outerHeight < windowHeight) { // 内容的高度小于browser viewport的高度时 (即 datas.length < 6)
        $(this.$el).css({
          'marginTop': (windowHeight - outerHeight + 20) + 'px'
        }) // 为组件增加一个marginTop, 避免因没有scroll导致无法触发新的加载事件
      } else {
        this.is_first = false // 组件此时不再视窗范围内，所以不会触发事件
      }

      this.$nextTick(function () {
        this.initIntersectionObserver()
      })
    },
    methods: {
      initIntersectionObserver: function () {
        let self = this
        let io = new window.IntersectionObserver(
          entries => {
            let outerHeight = $('body .container').outerHeight()
            let windowHeight = $(window).height()
            let marginTop = $(self.$el).css('marginTop')

            if (self.is_first) { // 该组件主要用于加载新的内容，用is_first避免页面第一次加载时就触发
              self.is_first = false
              self.is_visible = true
              return
            }

            if (!self.is_visible) { // 用is_visible使可见性变化时只触发其中的一次
              self.is_visible = true
              return
            }

            if (marginTop !== '0px' && outerHeight > windowHeight) { // 去掉已经没用的 marginTop
              $(self.$el).css({
                'marginTop': '0px'
              })
            }

            // if (entries[0].intersectionRatio <= 0) return
            self.is_visible = false
            self.$emit('bottom')
          }
        )

        io.observe(this.$el)
      }
    }
  }
</script>
