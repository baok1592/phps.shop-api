
<template>
  <div class="list">
    <transition appear appear-active-class="animated fadeInLeft">
      <div >
        <list-a :down="down"></list-a>
      </div>
    </transition>
  </div>
</template>

<script>
  import ListA from './components/list/List-a.vue' 
  
  
  export default { 
    data() {
      return {
        activeName: 'first',
        visible2: false,
        product:[], 
        addShow: false,
				down:false,
        eid:0,
        page:[]
      }
    }, 
    components: {
      ListA 
    }, 
    methods:{
			emit_one(){
				console.log(123)
			},
		},	 

		//vue生命函数
		mounted (){ 
		 
		} 
}
</script>

<style lang="less" scoped="">
.list{line-height: 30px;text-align:left;}

</style>
