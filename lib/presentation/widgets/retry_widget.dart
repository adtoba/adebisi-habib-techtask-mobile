import 'package:flutter/material.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';


class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    this.errorMessage,
    this.onPressed
  });

  final String? errorMessage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage!,
            style: CustomTextStyles.normal14.copyWith(
              color: Colors.white
            ),
          ),
          TextButton(
            child: Text(
              "Retry",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
            ),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}