import 'package:flutter/material.dart';
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
      heightFactor: 0.08,
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
    );
  }
}
