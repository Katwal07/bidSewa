import 'package:flutter/material.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import '../../../../../core/config/theme/colors.dart';

class BottomSizedBox1 extends StatelessWidget {
  const BottomSizedBox1({
    super.key,
    required this.onContinue,
  });

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      heightFactor: 0.12,
      child: Padding(
        padding: EdgeInsets.only(bottom: 3.52 * SizeConfigs.heightMultiplier),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onContinue,
            child: Text(
              "Continue",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.darkFontColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
