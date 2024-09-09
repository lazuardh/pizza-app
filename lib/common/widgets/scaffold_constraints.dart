import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/responsive.dart';

class ScaffoldConstraint extends StatefulWidget {
  final Key? _keyScaffold;
  final Function() _onWillPop;
  final bool? _resizeToAvoidBottomInset;
  final Widget? _appBar;
  final Color? _backgroundColor;
  final Widget? _bottomNavigationBar;
  final Widget _child;
  final Color? _colorContainer;
  final bool _isBottomNavBar;
  const ScaffoldConstraint({
    Key? keyGlobal,
    Key? keyScaffold,
    required Function() onWillPop,
    bool? resizeToAvoidBottomInset,
    Widget? appBar,
    Color? backgroundColor,
    Widget? bottomNavigationBar,
    required Widget child,
    Color? colorContainer,
    bool isBottomNavBar = false,
  })  : _keyScaffold = keyScaffold,
        _onWillPop = onWillPop,
        _resizeToAvoidBottomInset = resizeToAvoidBottomInset,
        _appBar = appBar,
        _backgroundColor = backgroundColor,
        _bottomNavigationBar = bottomNavigationBar,
        _child = child,
        _colorContainer = colorContainer,
        _isBottomNavBar = isBottomNavBar,
        super(key: keyGlobal);

  @override
  State<ScaffoldConstraint> createState() => _ScaffoldConstraintState();
}

class _ScaffoldConstraintState extends State<ScaffoldConstraint> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget._isBottomNavBar
          ? () async {
              return true;
            }
          : () async {
              widget._onWillPop();
              return false;
            },
      // () async {
      //   Navigator.pop(context);
      //   return false;
      // },
      child: Scaffold(
        key: widget._keyScaffold,
        resizeToAvoidBottomInset: widget._resizeToAvoidBottomInset,
        appBar: ResponsiveUtils(context).getMediaQueryWidth() > 430 &&
                widget._appBar != null
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: widget._appBar ?? const SizedBox(),
              ),
        backgroundColor: widget._backgroundColor,
        bottomNavigationBar: widget._bottomNavigationBar,
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: ResponsiveUtils(context).getMediaQueryWidth() > 430
                  ? 430
                  : double.infinity,
            ),
            padding: widget._appBar == null
                ? EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                  )
                : EdgeInsets.zero,
            color: widget._colorContainer ?? AppColors.white,
            child: Column(
              children: [
                if (ResponsiveUtils(context).getMediaQueryWidth() > 430 &&
                    widget._appBar != null) ...[
                  widget._appBar ?? const SizedBox(),
                ],
                Expanded(child: widget._child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
