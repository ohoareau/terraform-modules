module.exports = async () => ({
    '/favicon.ico': {name: 'favicon.ico', contentType: 'image/x-icon', header: {'Cache-Control': 'public, max-age=60, s-max-age=60'}},
    '/sitemap.xml': {name: 'sitemap.xml', contentType: 'application/xml', header: {'Cache-Control': 'public, max-age=60, s-max-age=60'}},
    '/robots.txt': {name: 'robots.txt', contentType: 'text/plain', header: {'Cache-Control': 'public, max-age=60, s-max-age=60'}},
    '/': {name: 'health.json', contentType: 'application/json', header: {'Cache-Control': 'no-cache, max-age=0, s-max-age=0'}},
})