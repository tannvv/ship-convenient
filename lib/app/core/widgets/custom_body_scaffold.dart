import 'package:flutter/cupertino.dart';

class CustomBodyScaffold extends StatelessWidget {
  const CustomBodyScaffold(
      {super.key,
      required this.header,
      required this.body,
      this.rateHeader = 1,
      this.rateBody = 15});
  final Widget header;
  final Widget body;
  final int rateHeader;
  final int rateBody;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(flex: rateHeader, child: header),
          Expanded(flex: rateBody, child: body)
        ],
      ),
    );
  }
}
