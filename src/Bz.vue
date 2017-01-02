<template>
  <div></div>
</template>

<script>
  export default {
    data: function () {
      return {
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
            if (self.is_first) { // 不考虑可见性,会导致第一次就会调用,用is_first避免第一次调用
              self.is_first = false
              return
            }
            // if (entries[0].intersectionRatio <= 0) return
            self.$emit('bottom')
          }
        )
        io.observe(this.$el)
      }
    }
  }
</script>
