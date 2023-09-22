part of 'filter_view.dart';

class FilterOptionsWidget extends StatelessWidget {
  const FilterOptionsWidget({
    super.key,
    required this.isMuscles,
    required this.viewModel,
    required this.list,
  });

  final bool isMuscles;
  final FilterViewModel viewModel;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: list.map(
        (value) {
          bool isSelected = false;
          if (isMuscles) {
            if (viewModel.selectedMuscles.contains(value)) {
              isSelected = true;
            }
          } else {
            if (viewModel.selectedTypes.contains(value)) {
              isSelected = true;
            }
          }
          return GestureDetector(
            onTap: () {
              if (isMuscles) {
                viewModel.onTapMuscles(value);
              } else {
                viewModel.onTapTypes(value);
              }
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 4.h),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                      border:
                          Border.all(color: isSelected ? Colors.green : Colors.black, width: 2.w)),
                  child: Text(
                    value,
                    style:
                        TextStyle(color: isSelected ? Colors.green : Colors.black, fontSize: 14.sp),
                  ),
                )),
          );
        },
      ).toList(),
    );
  }
}
