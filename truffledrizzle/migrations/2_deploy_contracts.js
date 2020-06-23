const MyStringStore = artifacts.require("MyStringStore");
const Contest = artifacts.require("Contest");

module.exports = function (deployer) {
    deployer.deploy(MyStringStore);
    deployer.deploy(Contest, "Miss Nigeria 2020", "1000000000000000000", "500000000000000000");
};