({
    appDir: '../site',
    baseUrl: 'scripts',
    dir: '../dist',
    mainConfigFile: '../site/scripts/main.js',
    findNestedDependencies: true,
    removeCombined: true,
    useStrict: true,
    keepBuildDir: false,
    preserveLicenseComments: false,
    optimize: 'uglify2',

    stubModules: ['cs'],

    modules: [
        {
            name: 'main',
            excludeShallow: [
                'css/css-builder',
                'less/lessc-server',
                'less/lessc'
            ],
            include: [/*'css', */'cs!config', 'cs!pages/home/home'],
            exclude: ['coffee-script']
        }
    ],

    uglify2: {
        mangle: true
    }
})
