var path = require('path'),
	config = {
		testing: {},
		development: {
			env: 'development',
			port		: 3001,
			cookie_secret: 'v3ber4geSh4r3D',
			db: {
				host	: 'localhost',
				port	: 3306,
				name	: 'dabar',
				user	: 'dabar',
				pass	: 'pwd@dabar33'
			},
			facebook: {
				secret: '655f1427c3cf1aeda4a18d2af5e8c4c1',
				appId: '2212776085617671'
			}
		},
		stagging: {},
		production: {}
	};


// set development as default environment
!process.env['NODE_ENV'] && (process.env['NODE_ENV'] = 'development');
config = config[process.env['NODE_ENV']];

module.exports = config;