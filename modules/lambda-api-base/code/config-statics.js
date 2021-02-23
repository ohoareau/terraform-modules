module.exports = () => ({
    '/favicon.ico': {
        name: 'favicon.ico',
        contentType: 'image/x-icon',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/favicon-16x16.png': {
        name: 'favicon-16x16.png',
        contentType: 'image/png',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/favicon-32x32.png': {
        name: 'favicon-32x32.png',
        contentType: 'image/png',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/favicon.png': {
        name: 'favicon-32x32.png',
        contentType: 'image/png',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/apple-touch-icon.png': {
        name: 'apple-touch-icon.png',
        contentType: 'image/png',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/android-chrome-192x192.png': {
        name: 'android-chrome-192x192.png',
        contentType: 'image/png',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/android-chrome-512x512.png': {
        name: 'android-chrome-512x512.png',
        contentType: 'image/png',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/site.webmanifest': {
        name: 'site.webmanifest',
        contentType: 'application/manifest+json',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/manifest.json': {
        name: 'site.webmanifest',
        contentType: 'application/manifest+json',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/sitemap.xml': {
        name: 'sitemap.xml',
        contentType: 'application/xml',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/robots.txt': {
        name: 'robots.txt',
        contentType: 'text/plain',
        headers: {'Cache-Control': 'public, max-age=60, s-max-age=60'}
    },
    '/healthz': {
        name: 'healthz.json',
        contentType: 'application/json',
        headers: {'Cache-Control': 'no-cache, max-age=0, s-max-age=0'}
    },
})