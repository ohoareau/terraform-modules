async function staticFileHandler({name, contentType, headers = {}, statusCode = 200}) {
    return {
        body: require('fs').readFileSync(`${__dirname}/statics/${name}`, null).toString('base64'),
        isBase64Encoded: true,
        statusCode,
        headers: {
            'Content-Type': contentType,
            ...headers,
        }
    }
}

let config = undefined;

const handler = async (event, context) => {
    config = (config || await (require('./config')())) || {};
    const path = (((event || {})['requestContext'] || {})['http'] || {})['path'];
    if ((config['statics'] || {})[path]) {
        // noinspection JSCheckFunctionSignatures
        return staticFileHandler(config['statics'][path], event, context);
    }
    // @todo

    if ((config['statics'] || {})['/']) {
        // noinspection JSCheckFunctionSignatures
        return staticFileHandler(config['statics']['/'], event, context);
    }
    return {
        body: '{}',
        isBase64Encoded: false,
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
        }
    }
};

module.exports = {handler}