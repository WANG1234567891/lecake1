module.exports = {
    chainWebpack: config => {
        //删除编译后的独立js文件上的预获取操作
        config.plugins.delete("prefetch")
    },
    // 配置跨域
    // devServer: {
    //     proxy: {
    //         '/api': {
    //             target: `https://www.runoob.com/try`,
    //             changeOrigin: true,
    //             pathRewrite: {
    //                 '^/api': ''
    //             }
    //         }
    //     }
    // }
}