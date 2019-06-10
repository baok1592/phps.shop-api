<template>
	<div>    
			<component :is="comview" :eid="eid" @emit_tangou="emit_tg" />
	</div>

</template>

<script>
	import {Loading} from 'element-ui'; 
	import {Api_url} from '@/common/config'
	//import Tuangou from './components/Tuangou.vue'	 
	import Pintuan from './components/Pintuan' 
	
	export default {
		name: 'Good', 
		props: ['eid'],
		data() {
			return { 
				comview:''
			}
		}, 
		components: { 
			Pintuan
		},
		methods: {
			is_comview(name){
				if(name=='tuan'){
					this.comview='Tuangou'		
				}
				if(name!='tuan'){
					this.comview='Pintuan'		
				}
			},
			emit_tg(){
				this.$emit('emit_tg')
			}
		},
		mounted() {
			this.is_comview('Pintuan')
		}
	}
</script>

<style lang="less">

</style>
