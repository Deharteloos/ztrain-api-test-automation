function afterScenario(){
    var info = karate.info;
    karate.log('after scenario:', info.scenarioName);
    karate.call('classpath:com/ztrain_api/cart/deleteFromCart.feature@TEST_OF-');
}