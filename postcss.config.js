// postcss.config.js
const purgecss = require('@fullhuman/postcss-purgecss')({

  // Specify the paths to all of the template files in your project
  content: [
    './src/**/*.html',
    './src/**/*.elm'
    // etc.
  ],

  // Include any special characters you're using in this regular expression
  defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || [],

  // Purgecss doesn't know how to look for things like computed classes. These
  // are mostly used background and text colours, so we're going to whitelist all
  // colours. This will bloat the bundle slightly, but it's more than worth the
  // tradeoff.
  whitelistPatterns: [
    /[1-9]00/
  ]
})

module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    ...process.env.NODE_ENV === 'production'
      ? [purgecss]
      : []
  ]
}
