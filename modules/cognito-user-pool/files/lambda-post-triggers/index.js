const AWS = require('aws-sdk');
const sns = new AWS.SNS();

const dispatch = async (type, operation, payload = {}, attributes = {}) =>
    sns.publish({
        Message: JSON.stringify(await payload),
        MessageAttributes: Object.entries({...attributes, type, operation, fullType: `${type}_${operation}`}).reduce((acc, [k, v]) => {
            acc[k] = {DataType: 'String', StringValue: v};
            return acc;
        }, {}),
        TopicArn: process.env.OUTGOING_TOPIC_ARN,
    }).promise()
;

module.exports = {
    handler: async (event) => {
        const { triggerSource, request, response, ...source } = event;
        switch (triggerSource) {
            case 'PostAuthentication_Authentication':
                const { userAttributes: user, ...extra } = request;
                await dispatch('user', 'login', {extra, source, ...user});
                break;
            default: // ignore
                break;
        }
        return event;
    },
};