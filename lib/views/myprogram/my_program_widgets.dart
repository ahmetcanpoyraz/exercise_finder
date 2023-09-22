part of 'my_program_view.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({
    super.key,
    required this.viewModel,
    required this.index,
  });

  final MyProgramViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: viewModel.currentIndex == index ? Colors.black.withOpacity(0.4) : Colors.grey,
            borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          child: Text(viewModel.itemsByGroups?[index].first.groupName ?? ""),
        ));
  }
}

class DissmissibleWidget extends StatelessWidget {
  const DissmissibleWidget({
    super.key,
    required this.viewModel,
    required this.tabIndex,
    required this.index,
  });

  final MyProgramViewModel viewModel;
  final int tabIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        viewModel.deleteItem(tabIndex, viewModel.itemsByGroups![tabIndex][index].id!);
      },
      background: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: Colors.red,
          ),
          margin: EdgeInsets.all(8.h),
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 12.h),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: CustomItemWidget(list: viewModel.itemsByGroups![tabIndex], index: index),
    );
  }
}
