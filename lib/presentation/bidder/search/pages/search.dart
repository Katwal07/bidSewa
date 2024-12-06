import 'package:flutter/material.dart';
import 'package:nepa_bid/core/config/assets/app_images.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';

class SearchPageBidder extends StatelessWidget {
  const SearchPageBidder({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDarkTheme
                        ? AppColors.darkContainerColor
                        : AppColors.lightContainerColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 40,
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      filled: true,
                      fillColor: isDarkTheme
                          ? AppColors.darkContainerColor
                          : AppColors.lightContainerColor,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 26,
                      ),
                      suffixIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ComponentsSizes.horizontalPadding,
            vertical: ComponentsSizes.defaultSpace * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop by Categories",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: isDarkTheme
                            ? AppColors.darkContainerColor
                            : AppColors.lightContainerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: Image(
                              image: AssetImage(AppImages.onboard1),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Hoodies",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: 10),
            ),
          ],
        ),
      )),
    );
  }
}
