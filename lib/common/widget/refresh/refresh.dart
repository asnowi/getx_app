import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/refresh/over_scroll_behavior.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Refresh extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final Widget content;
  final bool enablePullDown;
  final bool enablePullUp;

  Refresh({this.controller, this.onRefresh, this.onLoading, this.content,this.enablePullDown = true,this.enablePullUp = true});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      child: RefreshConfiguration.copyAncestor(
        context: context,
        child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: SmartRefresher(
            controller: this.controller,
            enablePullDown: this.enablePullDown,
            enablePullUp: this.enablePullUp,
            header: CustomHeader(
              builder: (BuildContext context, RefreshStatus mode) {
                Widget body;
                if (mode == RefreshStatus.canRefresh) {
                  body = textIndicator("松开刷新");
                } else if (mode == RefreshStatus.refreshing) {
                  body = textIndicator("加载中...");
                } else if (mode == RefreshStatus.idle) {
                  body = textIndicator("下拉刷新");
                } else if (mode == RefreshStatus.completed) {
                  body = textIndicator("加载成功");
                }
                return Container(
                  padding: EdgeInsets.only(top: 6,bottom: 10),
                  height: 76,
                  child: Center(
                    child: body,
                  ),
                );
              },
            ),
            footer: CustomFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("上拉加载", style: TextStyle(fontSize: 12));
                } else if (mode == LoadStatus.loading) {
                  body = Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey),
                            strokeWidth: 1.6,
                          ),
                          width: 12,
                          height: 12,
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text("加载中...", style: TextStyle(fontSize: 12))
                      ],
                    ),
                  );
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败！点击重试！", style: TextStyle(fontSize: 12));
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松手,加载更多!", style: TextStyle(fontSize: 12));
                } else {
                  body = Text("没有更多数据了!", style: TextStyle(fontSize: 12));
                }
                return Container(
                  height: 55.0,
                  padding: EdgeInsets.only(top: 6,bottom: 10),
                  child: Center(child: body),
                );
              },
            ),
            onRefresh: this.onRefresh,
            onLoading: this.onLoading,
            child: this.content,
          ),
        ),
        enableLoadingWhenFailed: true,
        maxUnderScrollExtent: 100.0,
        footerTriggerDistance: -45.0,
      ),
      enableLoadingWhenFailed: true,
      footerTriggerDistance: -60.0,
    );
  }

  Widget textIndicator(String statusStr) {
    return Container(
      child: Stack(
        children: [
          Lottie.asset(
            AssetsProvider.lottiePath('refresh'),
            // AssetsProvider.lottiePath('loadingYellow'),
            width: 96,
            alignment: Alignment.center,
          ),
          Positioned(
            bottom: -2,
            left: 24,
            right: 0,
            child: Text(
              statusStr,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
