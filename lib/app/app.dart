import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/geolocator/geolocator_cubit.dart';
import 'package:nepa_bid/common/bloc/pagination/bidder/pagination_cubit.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc/pagination_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc_newin/pagination_newsin_bloc.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_cubit.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_news_in_usecase.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_bloc.dart';
import 'package:nepa_bid/service_locator.dart';
import '../common/bloc/pagination/auctioneer/pagination_cubit_auction.dart';
import '../common/res/size_configs.dart';
import '../core/config/routes/routes.dart';
import '../core/config/routes/routes_name.dart';
import '../core/config/theme/theme.dart';
import '../domain/auctioneer/usecases/auction.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GeolocatorCubit(),
        ),
        BlocProvider(
          create: (context) =>
              PaginationCubit()..loadPost(sl<GetNewsInUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              PaginationCubitAuctioneer()..loadPost(sl<AuctionUseCase>()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => PaginationBloc(),
        ),
        BlocProvider(
          create: (context) => PaginationNewsInBloc(),
        ),
        BlocProvider(
          create: (context) => PaginationBlocForAuctioneer(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfigs().init(constraints, orientation);
              return MaterialApp(
                title: 'NEPA_BID',
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.system,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                initialRoute: AppRoutesName.splashScreen,
                onGenerateRoute: Routes.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
