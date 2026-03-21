import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class VerticalListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final VoidCallback onScrollEnd;
  final ScrollController? controller;
  final double loadMoreThreshold; // نسبة التحميل (0.7 لـ 70%)

  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onScrollEnd,
    this.controller,
    this.loadMoreThreshold = 0.7,
  });

  @override
  State<VerticalListView> createState() => _VerticalListViewState();
}

class _VerticalListViewState extends State<VerticalListView> {
  late final ScrollController _scrollController;
  bool _hasTriggeredLoadMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppPadding.p8),
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
      separatorBuilder: (context, index) {
        return const SizedBox(height: AppSize.s10);
      },
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxExtent = _scrollController.position.maxScrollExtent;
    final currentPosition = _scrollController.position.pixels;
    final threshold = maxExtent * widget.loadMoreThreshold;

    if (currentPosition >= threshold && !_hasTriggeredLoadMore) {
      _hasTriggeredLoadMore = true;
      widget.onScrollEnd();

      // إعادة تعيين بعد تأخير لمنع تكرار الاستدعاء
      Future.delayed(const Duration(seconds: 1), () {
        _hasTriggeredLoadMore = false;
      });
    }
  }
}
