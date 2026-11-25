//require trafficligt.js
const lib = require("./trafficlight");

//Export API
module.exports = app => {
    //welcome message
    /**
     *  /api/welcome: welcome message
     */
    app.get('/api/welcome', (req, res) => {
        res.status(200).json({
            message: "Welcome to Traffic-Light!",
            status: 'success'
        });
    });

    /**
     * /api/trafficlight
     */
    app.get('/api/trafficlight', (req, res) => {
        res.status(200).json({
            message: lib.trafficLight(undefined),
            status: 'success'
        });
    });

    /**
     * /api/trafficlight/:color
     * color is a parameter i.e. /api/trafficlight/red
     */
    app.get('/api/trafficlight/:color', (req, res) => {
        const color = req.params.color;
        const message = lib.trafficLight(color);
        if (message === undefined) {
            res.status(400).json({
                message: `Unknown color '${color}'`,
                status: 'error'
            });
        } else {
            res.status(200).json({
                message: message,
                status: 'success'
            });
        }
    });
}
