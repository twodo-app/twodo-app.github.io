const Bundler = require('parcel-bundler')
const Path = require('path')
const gh = require('gh-pages')

function deploy () {
  const parcel = new Bundler(Path.join(__dirname, './src/index.html'), {
    outDir: './dist',
    outFile: 'index.html',
    publicUrl: './',
    cache: true,
    cacheDir: '.cache',
    minify: true,
    scopeHoist: false,
    target: 'browser',
    bundleNodeModules: false,
    sourceMaps: false,
    detailedReport: true,
    autoInstall: true
  })

  parcel.bundle()
    .then(bundle => {
      gh.publish('dist', {
        branch: 'master',
        message: ':tada: Deploy site.'
      }, err => err ? console.error(err) : console.log('Site deployed!'))
    })
    .catch(err => {
      console.error(err)
    })
}

deploy()
