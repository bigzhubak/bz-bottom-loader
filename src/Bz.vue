<template>
  <div></div>
</template>

<script>
  export default {
    data: function () {
      return {
        is_visible: true,
        is_first: true
      }
    },
    mounted: function () {
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
          }
        )

        io.observe(this.$el)
      }
    }
  }
</script>
