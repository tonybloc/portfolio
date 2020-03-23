
/**
 * Github Module
 */
function github () {

    /**
     * Get module information
     */
    var _info = () => {
        return {
            name = "Github Module",
            auth = "Anthony Mochel",
            version = "1.0.0"
        }
    };

    return {
        info: () => _info()
    }
};


export { github }