part of 'home_view.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: ColorConstants.instance.kDarkGrey,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 0,
          color: ColorConstants.instance.kDarkGrey,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.h),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: 300.w,
                        child: CustomTextField(
                          hintText: "Search",
                          controller: viewModel.searchController,
                          onTap: () {
                            viewModel.chanceVisibleFilterList(true);
                          },
                          onChanged: (text) {
                            viewModel.filterSuggestions(text);
                          },
                        )),
                  ],
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      splashColor: ColorConstants.instance.chathamsBlue, // Splash color
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FilterView()),
                        );
                      },
                      child: SizedBox(width: 40.h, height: 40.h, child: const Icon(Icons.tune)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            )
          ],
        ),
      ),
      pinned: true,
    );
  }
}

class SuggestionListWidget extends StatelessWidget {
  const SuggestionListWidget({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Container(
            color: Colors.white,
            child: ListTile(
              title: Text(viewModel.suggestions[index]),
              onTap: () async {
                viewModel.chanceVisibleFilterList(false);
                FocusScope.of(context).unfocus();
                viewModel.searchController!.text = viewModel.suggestions[index];
                if (HomeScreenConstants.instance.muscleList
                    .contains(viewModel.searchController!.text)) {
                  await viewModel.getMuscles(viewModel.searchController!.text);
                } else if (HomeScreenConstants.instance.typeList
                    .contains(viewModel.searchController!.text)) {
                  await viewModel.getTypes(viewModel.searchController!.text);
                }
                // viewModel.chanceVisibleFilterList(false);
              },
            ),
          ),
        ),
        childCount: viewModel.visibleSearchList ? viewModel.suggestions.length : 0,
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.viewModel,
    required this.index,
  });

  final HomeViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    String? selectedGroupValue;
    return IconButton(
        onPressed: () {
          AlertDialogHelper.instance.showAlertForAddingItem(context, StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState2) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: viewModel.groups.isNotEmpty,
                    child: Column(
                      children: [
                        const Text("Select Group"),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomDropdownButton(
                            hintText: 'Select Group',
                            items: viewModel.groups,
                            errorText: "Lütfen ofis seçiniz.",
                            value: selectedGroupValue,
                            function: (value) {
                              viewModel.newGroupController!.text = "";
                              selectedGroupValue = value;

                              setState2(() {});
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Text("Or"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text("Add To New Group"),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    controller: viewModel.newGroupController,
                    onChanged: (value) {
                      selectedGroupValue = null;
                      setState2(() {});
                    },
                  ),
                ],
              );
            },
          ), () {
            viewModel.insertItemToDB(
                viewModel.responseList![index],
                viewModel.newGroupController!.text != ""
                    ? viewModel.newGroupController!.text
                    : selectedGroupValue);
          });
        },
        icon: const Icon(Icons.add_circle_outline));
  }
}
