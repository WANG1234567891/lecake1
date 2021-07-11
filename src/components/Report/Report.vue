<template>
  <div>
    <!-- 导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>数据统计</el-breadcrumb-item>
      <el-breadcrumb-item>数据报表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 卡片视图区域 -->
    <el-card>
      <div id="main" style="width: 600px; height: 400px"></div>
    </el-card>
  </div>
</template>

<script>
// 1.导入echarts
import * as echarts from "echarts";
export default {
  data() {
    return {};
  },
  methods: {},
  created() {},
  mounted() {
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById("main"));
    // 绘制图表
    // myChart.setOption({
    //   title: {
    //     text: "堆叠区域图",
    //   },
    //   tooltip: {
    //     trigger: "axis",
    //     axisPointer: {
    //       type: "cross",
    //       label: {
    //         backgroundColor: "#6a7985",
    //       },
    //     },
    //   },
    //   legend: {
    //     data: ["邮件营销", "联盟广告", "视频广告", "直接访问", "搜索引擎"],
    //   },
    //   toolbox: {
    //     feature: {
    //       saveAsImage: {},
    //     },
    //   },
    //   grid: {
    //     left: "3%",
    //     right: "4%",
    //     bottom: "3%",
    //     containLabel: true,
    //   },
    //   xAxis: [
    //     {
    //       type: "category",
    //       boundaryGap: false,
    //       data: ["周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    //     },
    //   ],
    //   yAxis: [
    //     {
    //       type: "value",
    //     },
    //   ],
    //   series: [
    //     {
    //       name: "邮件营销",
    //       type: "line",
    //       stack: "总量",
    //       areaStyle: {},
    //       data: [120, 132, 101, 134, 90, 230, 210],
    //     },
    //     {
    //       name: "联盟广告",
    //       type: "line",
    //       stack: "总量",
    //       areaStyle: {},
    //       data: [220, 182, 191, 234, 290, 330, 310],
    //     },
    //     {
    //       name: "视频广告",
    //       type: "line",
    //       stack: "总量",
    //       areaStyle: {},
    //       data: [150, 232, 201, 154, 190, 330, 410],
    //     },
    //     {
    //       name: "直接访问",
    //       type: "line",
    //       stack: "总量",
    //       areaStyle: {},
    //       data: [320, 332, 301, 334, 390, 330, 320],
    //     },
    //     {
    //       name: "搜索引擎",
    //       type: "line",
    //       stack: "总量",
    //       label: {
    //         normal: {
    //           show: true,
    //           position: "top",
    //         },
    //       },
    //       areaStyle: {},
    //       data: [820, 932, 901, 934, 1290, 1330, 1320],
    //     },
    //   ],
    // });


    var ROOT_PATH = 'https://cdn.jsdelivr.net/gh/apache/echarts-website@asf-site/examples';

var chartDom = document.getElementById('main');
// var myChart = echarts.init(chartDom);
var option;

var updateFrequency = 2000;
var dimension = 0;

var countryColors = {"Australia":"#00008b","Canada":"#f00","China":"#ffde00","Cuba":"#002a8f","Finland":"#003580","France":"#ed2939","Germany":"#000","Iceland":"#003897","India":"#f93","Japan":"#bc002d","North Korea":"#024fa2","South Korea":"#000","New Zealand":"#00247d","Norway":"#ef2b2d","Poland":"#dc143c","Russia":"#d52b1e","Turkey":"#e30a17","United Kingdom":"#00247d","United States":"#b22234"};

$.when(
    $.getJSON('https://cdn.jsdelivr.net/npm/emoji-flags@1.3.0/data.json'),
    $.getJSON(ROOT_PATH + '/data/asset/data/life-expectancy-table.json')
).done(function (res0, res1) {
    var flags = res0[0];
    var data = res1[0];
    var years = [];
    for (var i = 0; i < data.length; ++i) {
        if (years.length === 0 || years[years.length - 1] !== data[i][4]) {
            years.push(data[i][4]);
        }
    }

    function getFlag(countryName) {
        if (!countryName) {
            return '';
        }
        return (flags.find(function (item) {
            return item.name === countryName;
        }) || {}).emoji;
    }
    var startIndex = 10;
    var startYear = years[startIndex];

    var option = {
        grid: {
            top: 10,
            bottom: 30,
            left: 150,
            right: 80
        },
        xAxis: {
            max: 'dataMax',
            label: {
                formatter: function (n) {
                    return Math.round(n);
                }
            }
        },
        dataset: {
            source: data.slice(1).filter(function (d) {
                return d[4] === startYear;
            })
        },
        yAxis: {
            type: 'category',
            inverse: true,
            max: 10,
            axisLabel: {
                show: true,
                textStyle: {
                    fontSize: 14
                },
                formatter: function (value) {
                    return value + '{flag|' + getFlag(value) + '}';
                },
                rich: {
                    flag: {
                        fontSize: 25,
                        padding: 5
                    }
                }
            },
            animationDuration: 300,
            animationDurationUpdate: 300
        },
        series: [{
            realtimeSort: true,
            seriesLayoutBy: 'column',
            type: 'bar',
            itemStyle: {
                color: function (param) {
                    return countryColors[param.value[3]] || '#5470c6';
                }
            },
            encode: {
                x: dimension,
                y: 3
            },
            label: {
                show: true,
                precision: 1,
                position: 'right',
                valueAnimation: true,
                fontFamily: 'monospace'
            }
        }],
        // Disable init animation.
        animationDuration: 0,
        animationDurationUpdate: updateFrequency,
        animationEasing: 'linear',
        animationEasingUpdate: 'linear',
        graphic: {
            elements: [{
                type: 'text',
                right: 160,
                bottom: 60,
                style: {
                    text: startYear,
                    font: 'bolder 80px monospace',
                    fill: 'rgba(100, 100, 100, 0.25)'
                },
                z: 100
            }]
        }
    };

    // console.log(option);
    myChart.setOption(option);

    for (var i = startIndex; i < years.length - 1; ++i) {
        (function (i) {
            setTimeout(function () {
                updateYear(years[i + 1]);
            }, (i - startIndex) * updateFrequency);
        })(i);
    }

    function updateYear(year) {
        var source = data.slice(1).filter(function (d) {
            return d[4] === year;
        });
        option.series[0].data = source;
        option.graphic.elements[0].style.text = year;
        myChart.setOption(option);
    }
})

option && myChart.setOption(option);

  },
};
</script>

<style scoped>
.el-breadcrumb {
  margin-bottom: 15px;
  font-size: 12px;
}
</style>