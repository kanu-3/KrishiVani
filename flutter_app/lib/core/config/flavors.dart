enum Flavor {
  dev,
  prod,
}

class FlavorConfig {
  static late Flavor flavor;

  static bool get isDev => flavor == Flavor.dev;
  static bool get isProd => flavor == Flavor.prod;
}
