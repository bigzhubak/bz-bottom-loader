<template>
  <div></div>
</template>

<script>
  import $ from 'jquery'

  export default {
    data: function () {
      return {
        is_visible: true,
        is_first: true
      }
    },
    mounted: function () {
      let outerHeight = $('body').children('#app').outerHeight()
      let windowHeight = $(window).height()

      if (outerHeight < windowHeight) { // 内容的高度小于browser viewport的高度时 (例如当 datas.length < 6)
        $(this.$el).css({
          'marginTop': (windowHeight - outerHeight + 1) + 'px',
          'height': '1px'
        }) // 为组件增加一个marginTop, 避免因没有scroll导致无法触发新的加载事件
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
            if (self.is_first) { // 该组件主要用于加载新的内容，用is_first避免页面第一次加载时就触发
              self.is_first = false
              return
            }

            if (self.is_visible) { // 用is_visible使可见性变化时只触发其中的一次
              self.is_visible = false
              return
            }

            // if (entries[0].intersectionRatio <= 0) return
            self.is_visible = true
            self.$emit('bottom')
            self.$nextTick(function () { // 等到dom更新完毕再执行
              let outerHeight = $('body').children('#app').outerHeight()
              let windowHeight = $(window).height()
              let marginTop = parseInt($(self.$el).css('marginTop'), 10)
              let decrease = (marginTop - (outerHeight - windowHeight) + 2)

              if (decrease > 0) {
                $(self.$el).css({
                  'marginTop': decrease + 'px'
                }) // 随着body content高度增加,减小一定的marginTop
              } else {
                $(self.$el).css({
                  'marginTop': '0px',
                  'height': '0px'
                }) // 当body content高度大于browser viewport时,该组件不再需要尺寸
              }
            })
          }
        )

        io.observe(this.$el)
      }
    }
  }
</script>
