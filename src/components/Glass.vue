<template>
	<div class="glass">
		<div class="glass-wrap" @mousemove="move">
			<div class="glass-img"  @mouseenter="init" ref="glass">
				<img :src="img" alt="">
				<div class="msk" v-show="isglass" ref="msk" :style="{top:maskt + 'px',left:maskl + 'px'}" @mouseleave="isglass = false"></div>
			</div>
			<div class="bigimg-box" v-show="isglass">
				<img :src="img" alt="" ref="bigimg" :style="{top:bigt + 'px',left:bigl + 'px',width:bigW + 'px',height:bigH + 'px'}">
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		name:"Glass",
		props:{
			// 接收传入的图片
			img:{
				type:String,
				require: true
			},
			// 接收放大的倍数
			times:{
				type:Number,
				default:2
			}
		},
		data(){
			return {
				isglass:false,
				maskt:0,
				maskl:0,
				bigt:0,
				bigl:0,
				left:0,
				top:0,
				bigW:0,
				bigH:0
			}
		},
		methods:{
			init(e){
				// console.log(e)
				this.isglass = true;
				this.$nextTick(()=>{
					// console.log(this.$refs.glass.offsetHeight)
					// console.log(this.$refs.glass.offsetWidth)
					this.glassH = this.$refs.glass.offsetHeight;
					this.glassW = this.$refs.glass.offsetWidth;
					// console.log(this.$refs.msk.offsetHeight)
					// console.log(this.$refs.msk.offsetWidth)
					this.mskH = this.$refs.msk.offsetHeight;
					this.mskW = this.$refs.msk.offsetWidth;
					//查看xy的坐标位置
					// console.log(this.$refs.bigimg.offsetHeight)
					// console.log(this.$refs.bigimg.offsetWidth)
					this.bigH = this.glassH * this.times;
					this.bigW = this.glassW * this.times;
					this.left = e.x - e.offsetX;
					this.top = e.y - e.offsetY;
					// this.movemsk(e)
				})
			},
			move(e){
				this.movemsk(e);
			},
			movemsk(e){
				// console.log(e)
				let x = e.x - this.left;
				let y = e.y - this.top;
				// console.log(x,y)
				// 将限制蒙层区域限制在图片内
				this.maskl = x > this.mskH / 2 ? x > this.glassW - this.mskW /2 ? this.glassW - this.mskW : x - this.mskW / 2 : 0
				this.maskt = y > this.mskH / 2 ? y > this.glassH - this.mskH /2 ? this.glassH - this.mskH : y - this.mskH / 2 : 0
				this.bigt =0 - (this.maskt * this.bigH / this.glassH > this.bigH - this.glassH ? this.bigH - this.glassH : this.maskt * this.bigH / this.glassH) 
				this.bigl =0 - (this.maskl * this.bigW / this.glassW > this.bigW - this.glassW ? this.bigW - this.glassW : this.maskl * this.bigW / this.glassW)
				// console.log(this.maskl,this.maskt)
			}
		}

	}

</script>

<style>
	.glass{
		position: relative;
		width: 380px;
		height: 380px;
	}
	.glass-wrap{
		width: 380px;
		height: 380px;
		position: absolute;
	}
	.glass img{
		width: 100%;
		height: 100%;
	}
	.glass-img{
		position: relative;
	}
	.glass-img .msk{
		width: 100px;
		height: 100px;
		/* background-color: rgba(0,0,0,0); */
		border: 1px solid #f00e0e;
		position: absolute;
		opacity: 0.5;
		cursor: move;
	}
	.bigimg-box {
		width: 300px;
		height: 300px;
		position: absolute;
		top: 0;
		right: -130px;
		overflow: hidden;
		z-index: 999;
	}
	.glass .bigimg-box img{
		/* width: 1444px;
		height: 1444px; */
		position: absolute;
	}

</style>