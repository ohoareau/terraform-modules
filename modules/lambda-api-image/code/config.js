module.exports = async () => ({
    statics: await (require('./config-statics')()),
});