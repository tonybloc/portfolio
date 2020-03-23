
/**
 * Google Module
 */
function google () {

    /**
     * Get module information
     */
    var _info = () => {
        return {
            name = "Google Module",
            auth = "Anthony Mochel",
            version = "1.0.0"
        }
    };

    return {
        info: () => _info()
    }
};


export { google }