// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/presentation/auctioneer/post/widgets/modal_sheet/modal_sheet.dart';
import '../../../../../core/config/theme/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../bloc/date_time_picker_cubit/date_time_picker_cubit.dart';
import '../../bloc/date_time_picker_cubit/date_time_picker_state.dart';

class TopSizedBox1 extends StatefulWidget {
  TopSizedBox1({
    super.key,
    required this.isDarkTheme,
    required this.productNameCon,
    //required this.productCategoryCon,
    //required this.productConditionCon,
    required this.productDescCon,
    required this.onItemSelected,
    required this.onItemCategoryValue,
  });

  final bool isDarkTheme;
  final TextEditingController productNameCon;
  //final TextEditingController productCategoryCon;
  //final TextEditingController productConditionCon;
  final TextEditingController productDescCon;
  final void Function(String) onItemSelected;
  final void Function(String) onItemCategoryValue;


  @override
  State<TopSizedBox1> createState() => _TopSizedBox1State();
}

class _TopSizedBox1State extends State<TopSizedBox1> {
   String value = "Select Product Condition";
   String categoryValue = "Select Category";
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return FractionallySizedBox(
        alignment: Alignment.topCenter,
        heightFactor: 0.85,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDarkTheme
                ? AppColors.darkContainerColor
                : AppColors.lightContainerColor,
            borderRadius: BorderRadius.circular(
              ComponentsSizes.productItemRadius,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: ComponentsSizes.defaultSpace / 2,
                right: ComponentsSizes.defaultSpace / 2,
                top: ComponentsSizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFieldName(
                          context,
                          "Product Name",
                        ),
                        _buildTextField(
                          context,
                          "Ex. Nikon Coolpix A300 Digital Camera",
                          1,
                          1,
                          TextInputType.text,
                          widget.productNameCon,
                        ),
                      ],
                    ),
                  ),
                  _divider(),
                  GestureDetector(
                    onTap: () async {
                      final selectedValue = await showMenu<String>(
                        elevation: 0,
                        popUpAnimationStyle:
                            AnimationStyle(curve: Curves.easeInOut),
                        context: context,
                        position:
                            const RelativeRect.fromLTRB(400, 300, 50, 100),
                        color: widget.isDarkTheme
                            ? AppColors.darkBgColor
                            : AppColors.lightBgColor,
                        items: [
                          const PopupMenuItem(
                            value: "new",
                            child: Text("new"),
                          ),
                          const PopupMenuItem(
                            value: "old",
                            child: Text("old"),
                          )
                        ],
                      );

                      if (selectedValue != null) {
                        setState(() {
                          value = selectedValue;
                        });
                        widget.onItemSelected(selectedValue);
                      }
                    },
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFieldName(
                            context,
                            "Product Condition",
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                const Icon(Icons.check_circle_outline_outlined)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _divider(),
                  SizedBox(
                    child: GestureDetector(
                      onTap: () async {
                        final selectedCategory =
                            await AppBottomSheet.display(context);
                        if (selectedCategory != null) {
                          setState(
                            () {
                              categoryValue = selectedCategory;
                            },
                          );
                          widget.onItemCategoryValue(selectedCategory);
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFieldName(
                            context,
                            "Category",
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categoryValue,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                const Icon(Icons.check_circle_outline_outlined)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _divider(),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFieldName(
                          context,
                          "Start Time",
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.event),
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd HH:mm')
                                    .format(now)
                                    .toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _divider(),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFieldName(
                          context,
                          "End Time",
                        ),
                        BlocBuilder<DateTimePickerCubit, DateTimePickerState>(
                          builder: (context, state) {
                            if (state is DateInitialState) {
                              return SizedBox(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<DateTimePickerCubit>()
                                            .displayDateTime(context);
                                      },
                                      icon: const Icon(Icons.event),
                                    ),
                                    _buildTextFieldName(
                                      context,
                                      "select end time",
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is DateLoadedState) {
                              return SizedBox(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<DateTimePickerCubit>()
                                            .reset();
                                        context
                                            .read<DateTimePickerCubit>()
                                            .displayDateTime(context);
                                      },
                                      icon: const Icon(Icons.event),
                                    ),
                                    Text(
                                      DateFormat('yyyy-MM-dd HH:mm')
                                          .format(state.getCombinedDateTime!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                ),
                              );
                            }
                            if (state is DateLoadFailure) {
                              return SizedBox(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.event),
                                    ),
                                    Text(
                                      state.errorMessage,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  _divider(),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFieldName(
                          context,
                          "Product Description",
                        ),
                        _buildTextField(context, "Input here", 10, 4,
                            TextInputType.multiline, widget.productDescCon)
                      ],
                    ),
                  ),
                  _divider(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _divider() {
    return const Divider(
      color: AppColors.darkgrey,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }

  Widget _buildTextFieldName(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildTextField(
      BuildContext context,
      String hintText,
      int maxLines,
      int minLines,
      TextInputType keyboardType,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}
