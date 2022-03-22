function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    api_base_url: 'https://ztrain-shop.herokuapp.com',
    product: '61efb02b4e23dc71cab1331b'
  }
  var result = karate.callSingle('classpath:com/ztrain_api/user/login.feature@TEST_OF-704', config);
  config.authInfo = { token: result.resp.token, user: result.resp.user._id };
  return config;
}
