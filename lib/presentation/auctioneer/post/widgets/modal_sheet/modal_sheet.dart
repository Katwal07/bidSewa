import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_state.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_category_usecase.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../../common/res/size_configs.dart';
import '../../../../../core/config/theme/colors.dart';

class AppBottomSheet {
  static Future<String?> display(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return showModalBottomSheet(
      backgroundColor:isDarkTheme? AppColors.darkContainerColor: AppColors.lightContainerColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      builder: (_) {
        return BlocProvider(
            create: (context) => GenericCubit()
              ..execute(
                sl<GetCategoryUsecase>(),
              ),
            child: BlocBuilder<GenericCubit, GenericState>(
              builder: (context, state) {
                if (state is DataLoaded) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListView.separated(

                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, state.data[index].name);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CircleAvatar(
                                  radius: 6 * SizeConfigs.imageSizeMultiplier,
                                  backgroundColor: AppColors.transparent,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          state.data[index].image.url)),
                                ),
                              ),
                              SizedBox(
                                width: 3 * SizeConfigs.widthMultiplier,
                              ),
                              Text(
                                state.data[index].name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 2 * SizeConfigs.heightMultiplier,
                      ),
                      itemCount: state.data.length,
                    ),
                  );
                }
                if (state is DataFailure) {
                  return Text("Failure: ${state.errorMessage}");
                }
                return const SizedBox.shrink();
              },
            ));
      },
    );
  }
}
