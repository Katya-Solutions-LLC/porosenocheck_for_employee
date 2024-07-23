import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/home/components/employee_report_shimmer.dart';
import 'package:porosenocheckemployee/screens/home/components/greetings_component_shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      listAnimationType: ListAnimationType.None,
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        32.height,
        const GreetingsComponentShimmer(),
        const EmployeeReportShimmer(),
      ],
    );
  }
}
