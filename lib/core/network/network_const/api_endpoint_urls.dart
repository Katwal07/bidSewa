
class ApiEndpointUrls {
  ApiEndpointUrls._();

  /// Authentication
  static const String login = "user/login";
  static const String register = "user/register";
  static const String logout = "user/logout";

  /// Auctioneer
  static const String createItem = "auction/createitem";
  static const String getAllItems = "auction/allitems";
  static const String getUserProiler = "user/me";
}