import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        backgroundBlendMode: BlendMode.srcOver,
        color: Colors.black38,
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
