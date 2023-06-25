// migrations/2_deploy_contract.js
const MyContract = artifacts.require("Contract");

module.exports = function(deployer) {
  deployer.deploy(MyContract);
};
