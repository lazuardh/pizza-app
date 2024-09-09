import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/common/utils/assets.dart';

import '../utils/size.dart';

class CustomCachedImage extends StatelessWidget {
  final String _image;
  final double? _height;
  final double? _width;
  final BoxFit _fit;
  final double _borderRadius;
  const CustomCachedImage({
    Key? key,
    required String image,
    double? height,
    double? width,
    required BoxFit fit,
    double borderRadius = AppBorderRadius.small,
  })  : _image = image,
        _height = height,
        _width = width,
        _fit = fit,
        _borderRadius = borderRadius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Visibility(
        visible: _image.isNotEmpty,
        replacement: Image.asset(
          AppImageAssets.dummy,
          width: _width,
          height: _height,
          fit: _fit,
        ),
        child: CachedNetworkImage(
          imageUrl: _image,
          width: _width,
          height: _height,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(value: progress.progress),
          ),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: _fit),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            AppImageAssets.dummy,
            fit: _fit,
          ),
        ),
      ),
    );
  }
}

class CustomImageWrapper extends StatelessWidget {
  final String _image;
  final double? _height;
  final double? _width;
  final BoxFit _fit;
  final double _borderRadius;
  final bool _isNetworkImage;
  const CustomImageWrapper({
    Key? key,
    required String image,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
    double borderRadius = AppBorderRadius.small,
    required bool isNetworkImage,
  })  : _image = image,
        _height = height,
        _width = width,
        _fit = fit,
        _borderRadius = borderRadius,
        _isNetworkImage = isNetworkImage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: _isNetworkImage
          ? Visibility(
              visible: _image.isNotEmpty,
              replacement: Image.asset(
                AppImageAssets.dummy,
                width: _width,
                height: _height,
                fit: _fit,
              ),
              child: Image.network(
                _image,
                width: _width,
                height: _height,
                fit: _fit,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    width: _width,
                    height: _height,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    AppImageAssets.dummy,
                    width: _width,
                    height: _height,
                    fit: _fit,
                  );
                },
              ),
            )
          : Image.asset(
              _image,
              fit: _fit,
              width: _width,
              height: _height,
            ),
    );
  }
}

class CustomSvgWrapper extends StatelessWidget {
  final String _svgPath;
  final double? _height;
  final double? _width;
  final BoxFit _fit;
  final double _borderRadius;
  final bool _isNetwork;

  const CustomSvgWrapper({
    Key? key,
    required String svgPath,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
    double borderRadius = 0.0,
    required bool isNetwork,
  })  : _svgPath = svgPath,
        _height = height,
        _width = width,
        _fit = fit,
        _borderRadius = borderRadius,
        _isNetwork = isNetwork,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: _isNetwork
          ? Visibility(
              visible: _svgPath.isNotEmpty,
              replacement: SvgPicture.asset(
                'assets/placeholder.svg',
                width: _width,
                height: _height,
                fit: _fit,
              ),
              child: Image.network(
                _svgPath,
                width: _width,
                height: _height,
                fit: _fit,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    width: _width,
                    height: _height,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    'assets/error_placeholder.svg',
                    width: _width,
                    height: _height,
                    fit: _fit,
                  );
                },
              ),
            )
          : SvgPicture.asset(
              _svgPath,
              fit: _fit,
              width: _width,
              height: _height,
            ),
    );
  }
}
