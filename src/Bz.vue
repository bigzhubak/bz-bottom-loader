<template>
  <div>
  <br>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
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
            if (entries[0].intersectionRatio <= 0) return
            self.$emit('bottom')
          }
        )
        io.observe(this.$el)
      }
    }
  }
</script>
