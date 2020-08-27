var path = require('path');
var MiniCssExtractPlugin = require('mini-css-extract-plugin');
var OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
var VueLoaderPlugin = require('vue-loader/lib/plugin');
//process.env.NODE_ENV = 'production';

module.exports = {
  mode: 'development',
  entry: './assets/javascripts/index.js',
  output: {
    path: path.resolve(__dirname, 'public'),
    filename: 'index.bundle.js'
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: '[name].bundle.css',
    }),
    new OptimizeCssAssetsPlugin({
      assetNameRegExp: /\.css$/g,
      cssProcessor: require('cssnano'),
      cssProcessorPluginOptions: {
        preset: ['default', { discardComments: { removeAll: true } }],
      },
      canPrint: true
    }),
    new VueLoaderPlugin(),
  ],
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              publicPath: './public/',
            },
          },
          // Translates CSS into CommonJS
          'css-loader',
          // Compiles Sass to CSS
          'sass-loader',
        ],
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      },
    ],
  },
};
