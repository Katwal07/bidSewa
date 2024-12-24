import 'package:flutter/material.dart';
import 'package:nepa_bid/presentation/auctioneer/post/pages/post.dart';
import 'package:nepa_bid/presentation/auctioneer/search/pages/search_screen.dart';

import '../../../auctioneer/home/pages/home.dart';
import '../../../auctioneer/profile/pages/profile.dart';


List<Widget> bottomNavScreen =[
  const HomeScreen(),
  const SearchScreen(),
  const PostScreen(),
  const ProfileScreen()
];