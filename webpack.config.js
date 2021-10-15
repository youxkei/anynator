const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const isDevelopment = process.env.NODE_ENV !== "production";

module.exports = {
  mode: isDevelopment ? "development" : "production",

  entry: {
    main: "./src/index.bs.js"
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: "src/index.html",
    }),
  ],

  output: {
    path: path.resolve(__dirname, "./dist"),
    filename: "index.js",
  },
}
