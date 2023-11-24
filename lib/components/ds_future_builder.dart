import 'package:database_project/colors.dart';
import 'package:flutter/material.dart';

import 'ds_standard_text.dart';

class DSFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final String messageWhenEmpty;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const DSFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    required this.messageWhenEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else if (snapshot.hasData) {
          if (_isDataEmpty(snapshot.data)) {
            return Center(
                child: DSStandardText(
              text: messageWhenEmpty,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: DSColors.primaryTextBlack,
            ));
          } else {
            return builder(context, snapshot);
          }
        } else {
          return const DSStandardText(
            text: 'No data available',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: DSColors.primaryTextBlack,
          );
        }
      },
    );
  }

  bool _isDataEmpty(dynamic data) {
    if (data is Iterable) {
      return data.isEmpty;
    }
    return false;
  }

  Widget _buildLoadingWidget() {
    return Container(
        height: 80, width: 80, child: const CircularProgressIndicator());
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: DSStandardText(
        text: 'Error: $error',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: DSColors.primaryTextBlack,
      ),
    );
  }
}
