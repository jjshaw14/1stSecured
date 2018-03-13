var webpack  = require('webpack')
var path     = require('path')
var NODE_ENV = process.env.NODE_ENV || 'development'

var plugins = [], devtool

if (NODE_ENV === 'development') {
  var LiveReload =  require('webpack-livereload-plugin')
  plugins.push(new LiveReload())

  devtool = 'source-map'
}

plugins.push(new webpack.optimize.CommonsChunkPlugin({
  name: 'vendor',
  filename: '../app/assets/javascripts/vendor.bundle.js',
  chunks: ['core'],
  minChunks: Infinity
}))

plugins.push(new webpack.optimize.CommonsChunkPlugin({
  name: 'core',
  filename: '../app/assets/javascripts/core.bundle.js',
  chunks: ['admin', 'dealer'],
  minChunks: Infinity
}))

module.exports = {
  entry: {
    vendor: './app/assets/client/core/vendor.js',
    core: './app/assets/client/core/index.js',
    admin: './app/assets/client/admin/index.js',
    dealer: './app/assets/client/dealer/index.js'
  },
  output: {
    path: __dirname + '/public',
    filename: '../app/assets/javascripts/[name].bundle.js'
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
      {
        test: /\.s?css$/,
        loaders: [
          'style-loader',
          'css-loader?sourceMap',
          {
            loader: 'sass-loader',
            options: {
              includePaths: [
                path.resolve(__dirname, './node_modules'),
                path.resolve(__dirname, './app/assets/client/core/stylesheets')
              ]
            }
          },
          'postcss-loader'
        ]
      },
      { test: /\.(jpg|png)$/, loader: 'file-loader?name=/assets/[hash].[ext]' },
      { test: /\.woff2?(\?v=\d+\.\d+\.\d+)?$/, loader: 'url-loader?limit=10000&minetype=application/font-woff&name=/assets/[hash].[ext]' },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,    loader: 'url-loader?limit=10000&minetype=application/octet-stream&name=/assets/[hash].[ext]' },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,    loader: 'file-loader?name=/assets/[hash].[ext]' },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,    loader: 'url-loader?limit=10000&minetype=image/svg+xml&name=/assets/[hash].[ext]' }
    ]
  }
}
