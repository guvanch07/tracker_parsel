import 'package:flutter/cupertino.dart';

const int kMockupHeight = 812;
const int kMockupWidth = 375;

double getWidthRatio(BuildContext context) =>
    MediaQuery.of(context).size.width / kMockupWidth;

double getHeightRatio(BuildContext context) =>
    MediaQuery.of(context).size.height / kMockupHeight;
