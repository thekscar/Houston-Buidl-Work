const Prediction = artifacts.require("Prediction.sol");

contract("Prediction", (accounts) => {

    let prediction; 
    const creator = accounts[0];

    beforeEach(async() => {
        prediction = await Prediction.new({from:creator});
    })

    it('Should be owned by the first account', async() => {
        let theOwner = await prediction.owner(); 
        assert.equal(theOwner, creator);
    })


}) 
