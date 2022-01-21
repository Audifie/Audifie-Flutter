import 'package:audifie_version_1/core/constants/palette.dart';

import '../service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../size_config.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  const LoadingWidget({Key? key, this.size}) : super(key: key);

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.center,
        child: SpinKitWave(
          type: SpinKitWaveType.center,
          itemCount: 6,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: sc.width(2)),
              decoration: BoxDecoration(
                color: Palette.primary,
                borderRadius: BorderRadius.circular(sc.height(10)),
              ),
            );
          },
          size: size ?? MediaQuery.of(context).size.width * .20,
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      body: Center(
        child: SpinKitWave(
          type: SpinKitWaveType.center,
          itemCount: 6,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: sc.width(2)),
              decoration: BoxDecoration(
                color: Palette.primary,
                borderRadius: BorderRadius.circular(sc.height(10)),
              ),
            );
          },
          size: MediaQuery.of(context).size.width * .20,
        ),
      ),
    );
  }
}
