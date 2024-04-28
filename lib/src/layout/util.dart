import '../config/index.dart';

class SizerUtil {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceTypes deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  /// Sets the Screen's size and Device's Orientation,
  /// BoxConstraints, Height, and Width
  static void setScreenSize(BoxConstraints constraints, Orientation currentOrientation) {
    /// Sets boxconstraints and orientation
    boxConstraints = constraints;
    orientation = currentOrientation;

    /// Sets screen width and height
    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth;
      height = boxConstraints.maxHeight;
    } else {
      width = boxConstraints.maxHeight;
      height = boxConstraints.maxWidth;
    }

    /// Sets ScreenType
    if (kIsWeb) {
      deviceType = DeviceTypes.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      if ((orientation == Orientation.portrait && width < 600) || (orientation == Orientation.landscape && height < 600)) {
        deviceType = DeviceTypes.mobile;
      } else {
        deviceType = DeviceTypes.tablet;
      }
    } else if (Platform.isMacOS) {
      deviceType = DeviceTypes.mac;
    } else if (Platform.isWindows) {
      deviceType = DeviceTypes.windows;
    } else if (Platform.isLinux) {
      deviceType = DeviceTypes.linux;
    } else {
      deviceType = DeviceTypes.fuchsia;
    }
  }

  ///for responsive web
  static getWebResponsiveSize({smallSize, mediumSize, largeSize}) {
    return width < 600
        ? smallSize

        ///'phone'
        : width >= 600 && width <= 1024
            ? mediumSize

            ///'tablet'
            : largeSize;

    ///'desktop';
  }
}

/// Type of Device
///
/// This can be either mobile or tablet
enum DeviceTypes { mobile, tablet, web, mac, windows, linux, fuchsia }
