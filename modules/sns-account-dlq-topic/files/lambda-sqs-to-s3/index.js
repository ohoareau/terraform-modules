const AWS = require('aws-sdk');
const s3 = new AWS.S3();
const sqs = new AWS.SQS();

module.exports = {
    handler: async (event, {awsRequestId}) => {
        if (!event.Records || !event.Records.length) return;
        await Promise.all(event.Records.map(async ({receiptHandle, eventSourceARN, body}, index) => {
            const splits = eventSourceARN.split(':');
            await s3.putObject({
                Body: {receiptHandle, eventSourceARN, body: JSON.parse(body)},
                Bucket: process.env.S3_BUCKET_ID,
                Key: `${process.env.S3_BUCKET_KEY_PREFIX}${awsRequestId}-${index}.json`,
            }).promise();
            await sqs.deleteMessage({
                QueueUrl: sqs.endpoint.href + splits[4] + '/' + splits[5],
                ReceiptHandle: receiptHandle,
            }).promise();
        }));
    },
};