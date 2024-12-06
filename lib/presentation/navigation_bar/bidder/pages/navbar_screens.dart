import 'package:flutter/material.dart';
import 'package:nepa_bid/presentation/bidder/home/pages/home.dart';
import 'package:nepa_bid/presentation/bidder/search/pages/search_page_nav.dart';
import '../../../bidder/profile/pages/profile.dart';
import '../../../bidder/wishlist/pages/wishlist.dart';


List<Widget> bottomNavScreen =[
  const HomePageBidder(),
  const SearchPageNav(),
  const WishlistPageBidder(),
  const ProfilePageBidder(),
];