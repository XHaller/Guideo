module.exports = function (app) {
    app.use('/login', require('./routes/login'));
    app.use('/signup', require('./routes/signup'));
};

