import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//cool progress indicator))
class OwnProgressIndicator extends StatelessWidget {
  const OwnProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitSpinningLines(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
