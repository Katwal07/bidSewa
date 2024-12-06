import 'package:flutter/material.dart';
import 'package:nepa_bid/core/config/assets/app_images.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';

class SeeAllCategorySection extends StatelessWidget {
  const SeeAllCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: isDarkTheme ? AppColors.darkContainerColor : AppColors.lightContainerColor,
                child: const Icon(Icons.arrow_back,size: 26,),),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ComponentsSizes.horizontalPadding,
            vertical: ComponentsSizes.defaultSpace),
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
                physics: const ScrollPhysics(),
                shrinkWrap: true,
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
