'use strict';

module.exports = (function() {
    return [{
        protocol: "github",
        github: {
            author: "fis-components"
        },
        repos: 'https://github.com/fex-team/webuploader.git',
        version: '0.1.5',
        description: 'It's a new file uploader solution! http://fex.baidu.com/webuploader',
        build: 'npm install && npm install grunt-cli && ./node_modules/.bin/grunt dist',
        dependencies: [
            "jquery@>=1.6"
        ],
        mapping: [
            {
                reg: /^\/dist\/(.*?)$/,
                release: '$&'
            },
            {
                reg: /^\/src\/(.*?)$/,
                release: '$1'
            },
            {
                reg: '*',
                release: false
            }
        ]
    }];
})();