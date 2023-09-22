import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../base_viewmodel/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget?) onPageBuilder;

  final T viewModel;
  final Function(T model) onModelReady;
  const BaseView(
      {Key? key, required this.onPageBuilder, required this.viewModel, required this.onModelReady})
      : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T model;

  @override
  void initState() {
    model = widget.viewModel;
    widget.onModelReady(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: (context, model, Widget? child) => model.isLoadingPage
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
                child: widget.onPageBuilder(context, model, child),
              ),
      ),
    );
  }
}
