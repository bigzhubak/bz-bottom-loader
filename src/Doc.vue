<template>
  <doc name="bz-bottom-loader"
    desc="拉到底部加载"
    :parm_desc="parm_desc"
    :parms="parms"
    :code="code"
    >
    <div class="ui grid">
      <div  v-for="data in datas" class="sixteen wide column">
        <div class="ui card">
          <div class="content">
            <a class="description">{{data}}</a>
          </div>
        </div>
      </div>
    </div>
    <bottom-loader v-on:bottom="call_back"></bottom-loader>
  </doc>
</template>

<script>
  import BottomLoader from './Bz'
  import Doc from 'bz-doc'
  export default {
    components: {
      BottomLoader,
      Doc
    },
    data: function () {
      return {
        datas: [1, 2, 3, 4, 5],
        parms: [
          {parm: 'v-on:bottom', desc: '事件触发, 滚到底部的回调函数'}
        ],
        parm_desc: `把这个组件放在底部`,
        code: `<bottom-loader v-on:bottom="call_back"></bottom-loader>`
      }
    },
    methods: {
      call_back: function () {
        this.datas.push(this.datas.length + 1)
      }
    }
  }
</script>
