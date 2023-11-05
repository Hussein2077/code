// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/core/screen_util.dart';

/// @nodoc
typedef ZegoRebuildFactor = bool Function(
  MediaQueryData old,
  MediaQueryData data,
);

/// @nodoc
typedef ZegoScreenUtilInitBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

/// @nodoc
class ZegoRebuildFactors {
  const ZegoRebuildFactors._();

  static bool size(MediaQueryData old, MediaQueryData data) {
    return old.size != data.size;
  }

  static bool orientation(MediaQueryData old, MediaQueryData data) {
    return old.orientation != data.orientation;
  }

  static bool sizeAndViewInsets(MediaQueryData old, MediaQueryData data) {
    return old.viewInsets != data.viewInsets;
  }

  static bool all(MediaQueryData old, MediaQueryData data) {
    return old != data;
  }
}

/// @nodoc
class ZegoScreenUtilInit extends StatefulWidget {
  /// A helper widget that initializes [ZegoScreenUtil]
  const ZegoScreenUtilInit({
    Key? key,
    required this.builder,
    this.child,
    this.rebuildFactor = ZegoRebuildFactors.size,
    this.designSize = ZegoScreenUtil.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    this.useInheritedMediaQuery = false,
  }) : super(key: key);

  final ZegoScreenUtilInitBuilder builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;
  final bool useInheritedMediaQuery;
  final ZegoRebuildFactor rebuildFactor;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  @override
  State<ZegoScreenUtilInit> createState() => _ZegoScreenUtilInitState();
}

/// @nodoc
class _ZegoScreenUtilInitState extends State<ZegoScreenUtilInit>
    with WidgetsBindingObserver {
  MediaQueryData? _mediaQueryData;

  bool wrappedInMediaQuery = false;

  WidgetsBinding get binding => WidgetsFlutterBinding.ensureInitialized();

  MediaQueryData get mediaQueryData => _mediaQueryData!;

  MediaQueryData get newData {
    if (widget.useInheritedMediaQuery) {
      final data = MediaQuery.maybeOf(context);

      if (data != null) {
        wrappedInMediaQuery = true;
        return data;
      }
    }

    return MediaQueryData.fromWindow(binding.window);
  }

  Widget get child {
    return widget.builder.call(context, widget.child);
  }

  _updateTree(Element el) {
    el.markNeedsBuild();
    el.visitChildren(_updateTree);
  }

  @override
  void initState() {
    super.initState();
    // mediaQueryData = newData;
    binding.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final old = _mediaQueryData!;
    final data = newData;

    if (widget.rebuildFactor(old, data)) {
      _mediaQueryData = data;
      _updateTree(context as Element);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaQueryData ??= newData;
    didChangeMetrics();
  }

  @override
  void dispose() {
    binding.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    if (mediaQueryData.size == Size.zero) return const SizedBox.shrink();
    if (!wrappedInMediaQuery) {
      return MediaQuery(
        // key: GlobalObjectKey('mediaQuery'),
        data: mediaQueryData,
        child: Builder(
          builder: (__context) {
            ZegoScreenUtil.init(
              __context,
              designSize: widget.designSize,
              splitScreenMode: widget.splitScreenMode,
              minTextAdapt: widget.minTextAdapt,
            );
            return child;
          },
        ),
      );
    }

    ZegoScreenUtil.init(
      _context,
      designSize: widget.designSize,
      splitScreenMode: widget.splitScreenMode,
      minTextAdapt: widget.minTextAdapt,
    );

    return child;
  }
}
