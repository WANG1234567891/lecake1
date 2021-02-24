const webpack = require("webpack");
module.exports = {
    chainWebpack: config => {
        //删除编译后的独立js文件上的预获取操作
        config.plugins.delete("prefetch")
    },
    // 配置跨域
    devServer: {
        proxy: {
            '/api': {
                // target: `https://www.runoob.com/try`,
                target: "http://127.0.0.1:3000",
                changeOrigin: true,
                pathRewrite: {
                    '^/api': ''
                }
            }
        }
    },

    // 引入jq的配置3
    configureWebpack: {

        plugins: [
            new webpack.ProvidePlugin({
                $: "jquery",
                jQuery: "jquery",
                "window.jQuery": "jquery",
                Popper: ["popper.js", "default"]
            })
        ]
    }
}