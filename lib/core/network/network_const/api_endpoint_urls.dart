
class ApiEndpointUrls {
  ApiEndpointUrls._();

  /// Authentication
  static const String login = "user/login";
  static const String register = "user/register";
  static const String logout = "user/logout";

  /// Auctioneer
  static const String createItem = "auction/createitem";
  static const String getAllItems = "auction/allitems";
  static const String getUserProfile = "user/me";

  /// Bidder
  static const String getItemsDetails = "auction/item/";
  static const String bidItem = "bid/placebid/";
}