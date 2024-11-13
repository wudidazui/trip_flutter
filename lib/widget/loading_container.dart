import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;
  const LoadingContainer(
      {super.key,
      this.cover = false,
      required this.isLoading,
      required this.child});

  get _loadingView => Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return cover
        ? Stack(
            children: [child, isLoading ? _loadingView : Container()],
          )
        : isLoading
            ? _loadingView
            : child;
  }
}
