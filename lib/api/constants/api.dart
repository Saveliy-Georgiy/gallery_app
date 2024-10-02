class Api {
  Api._();
  static const String env = String.fromEnvironment('env', defaultValue: 'dev');

  static const String baseUrl = 'https://pixabay.com/api';
  static const String pixabayApiKey = '46104914-9bb62297136b4f0c7cfa83b55';
  static const String proxyUrl = env == 'dev'
      ? 'https://thingproxy.freeboard.io/fetch'
      : 'https://yacdn.org/proxy';
}
