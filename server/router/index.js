module.exports = function (app) {
    app.use('/login', require('./routes/login'));
    app.use('/signup', require('./routes/signup'));
    app.use('/event', require('./routes/event'));
    app.use('/note', require('./routes/note'));
};

