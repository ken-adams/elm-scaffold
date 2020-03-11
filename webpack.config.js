const path = require("path");
const webpack = require("webpack");
const CleanWebpackPlugin = require("clean-webpack-plugin");

module.exports = {
    entry: {
        app: ["./src/index.js"]
    },

    output: {
        path: path.resolve(__dirname + "/dist"),
        filename: "[name].js"
    },

    module: {
        rules: [
            {
                test: /\.(css|scss)$/,
                use: ["style-loader", "css-loader"]
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: "file-loader?name=[name].[ext]"
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: "elm-webpack-loader?verbose=true&output=main.js"
            },
            {
                test: /\.json/,
                loader: "json-loader"
            },
            {
                test: /\.js?$/,
                exclude: /node_modules/,
                loader: "babel-loader",
                query: {
                    presets: ["env"]
                }
            }
        ],

        noParse: /\.elm$/
    },

    plugins: [new CleanWebpackPlugin(["dist"]), new webpack.optimize.UglifyJsPlugin({ mangle: false })],

    devServer: {
        inline: true,
        stats: { colors: true },
        historyApiFallback: {
            index: "./src/index.html"
        }
    }
};
