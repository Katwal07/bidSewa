
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
  static const String getMyAuctionItems = "auction/user/";

  /// Bidder
  static const String getItemsDetails = "auction/item/";
  static const String bidItem = "bid/placebid/";
  static const String searchItem = "auction/search-auctions?";
  static const String category = "category";
  static const String getBidDetails = "bid/";

  /// search
  static const String searchKeyword = "keyword";
}