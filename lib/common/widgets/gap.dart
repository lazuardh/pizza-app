import 'package:flutter/material.dart';

import '../utils/size.dart';

class Gap extends StatelessWidget {
  const Gap({
    Key? key,
    double height = AppGap.small,
    double width = AppGap.small,
  })  : _height = height,
        _width = width,
        super(key: key);

  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
    );
  }
}
