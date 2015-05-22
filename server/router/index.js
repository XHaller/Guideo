module.exports = function (app) {
    app.use('/login', require('./routes/login'));
    app.use('/signup', require('./routes/signup'));
    app.use('/event', require('./routes/event'));
    app.use('/note', require('./routes/note'));
    app.use('/site', require('./routes/site'));
    app.use('/interest', require('./routes/interest'));
    app.use('/site/map', require('./routes/route'));
};

