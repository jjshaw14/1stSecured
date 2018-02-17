var path     = require('path')
var NODE_ENV = process.env.NODE_ENV || 'development'

var plugins = [], devtool

if (NODE_ENV === 'development') {
  var LiveReload =  require('webpack-livereload-plugin')
  plugins.push(new LiveReload())

  devtool = 'source-map'
}

module.exports = {
  entry: './app/assets/client/entry.js',
  output: {
    path: __dirname + '/public',
    filename: '../app/assets/javascripts/bundle.js'
  },
  devtool: devtool,
  plugins: plugins,
  module: {
    rules: [
      {
        enforce: 'pre',
        test: /\.html$/,
        loader: 'htmlhint-loader',
        exclude: /node_modules/,
        options: {
          configFile: path.resolve(__dirname, '.htmlhintrc')
        }
      },
      { test: /\.html$/, loader: 'raw-loader' },
      {
        enforce: 'pre',
        test: /\.js$/,
        loader: 'eslint-loader',
        exclude: /(node_modules|vendor)/,
        options: {
          configFile: path.resolve(__dirname, '.eslintrc')
        }
      },
      { test: /\.s?css$/, loaders: ['style-loader', 'css-loader?sourceMap', 'sass-loader?includePaths[]=' + path.resolve(__dirname, './node_modules'), 'postcss-loader'] },
      { test: /\.(jpg|png)$/, loader: 'file-loader?name=/assets/[hash].[ext]' },
      { test: /\.woff2?(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?limit=10000&minetype=application/font-woff&name=/assets/[hash].[ext]' },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,    loader: 'url-loader?limit=10000&minetype=application/octet-stream&name=/assets/[hash].[ext]' },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,    loader: 'file-loader?name=/assets/[hash].[ext]' },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,    loader: 'url-loader?limit=10000&minetype=image/svg+xml&name=/assets/[hash].[ext]' }
    ]
  }
}