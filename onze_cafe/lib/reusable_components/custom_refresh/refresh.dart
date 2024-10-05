import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/reusable_components/custom_refresh/refresh_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Refresh extends StatelessWidget {
  const Refresh({
    super.key,
    required this.refreshController,
    required this.child,
    required this.onRefresh,
    required this.bgColor,
    required this.gif,
  });
  final RefreshController refreshController;
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color bgColor;
  final ImageProvider gif;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RefreshCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<RefreshCubit>();
        return Scaffold(
          backgroundColor: bgColor,
          body: BlocBuilder<RefreshCubit, RefreshState>(
            builder: (context, state) {
              return SmartRefresher(
                controller: refreshController,
                onRefresh: () {
                  cubit.refresh().then((_) {
                    refreshController.refreshCompleted();
                  });
                },
                header: CustomHeader(
                  builder: (BuildContext context, RefreshStatus? status) {
                    if (status == RefreshStatus.refreshing) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: AspectRatio(
                            aspectRatio: 6,
                            child: Image(
                              image: gif,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                child: child,
              );
            },
          ),
        );
      }),
    );
  }
}
