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
            create: true,
            include: [
                'css',
                'main',
                'cs!pages/home/home'
            ],
            excludeShallow: [
                'css/css-builder',
                'less/lessc-server',
                'less/lessc'
            ],
            exclude: ['coffee-script'],
            stubModules: ['cs']
        }
    ]
})
