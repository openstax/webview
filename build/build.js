({
    appDir: '../site',
    baseUrl: 'scripts',
    dir: '../dist',
    mainConfigFile: '../site/scripts/config.js',
    findNestedDependencies: true,
    removeCombined: true,
    keepBuildDir: false,
    preserveLicenseComments: false,
    optimize: 'uglify2',

    modules: [
        {
            name: 'main',
            excludeShallow: [
                'css/css-builder',
                'less/lessc-server',
                'less/lessc'
            ],
            include: [
                'cs!pages/home/home'
            ],
            exclude: ['coffee-script'],
            stubModules: ['cs']
        }
    ]
})
