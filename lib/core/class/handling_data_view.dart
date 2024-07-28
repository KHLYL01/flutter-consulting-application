import 'package:flutter/material.dart';
import 'package:my_project/core/class/status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : statusRequest == StatusRequest.offlineFailure
            ? const Center(
                child: Text(
                'offline failure',
                style: TextStyle(fontSize: 30),
              ))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(
                    child: Text(
                    'server failure',
                    style: TextStyle(fontSize: 30),
                  ))
                : statusRequest == StatusRequest.failure
                    ? const Center(
                        child: Text(
                        'failure',
                        style: TextStyle(fontSize: 30),
                      ))
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : statusRequest == StatusRequest.offlineFailure
            ? const Center(
                child: Text(
                'offline failure',
                style: TextStyle(fontSize: 30),
              ))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(
                    child: Text(
                    'server failure',
                    style: TextStyle(fontSize: 30),
                  ))
                : widget;
  }
}
