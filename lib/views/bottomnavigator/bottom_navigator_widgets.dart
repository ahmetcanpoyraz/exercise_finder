part of 'bottom_navigator_view.dart';

class ButtomNavigationBarWidget extends StatelessWidget {
  const ButtomNavigationBarWidget({
    super.key,
    required this.viewModel,
  });

  final CustomBottomNavigationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ClipRRect(
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          enableFeedback: false,
          selectedFontSize: 0,
          backgroundColor: Colors.white,
          currentIndex: viewModel.controller,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          onTap: (index) {
            viewModel.changeController(index);
            if (index == 1) {
              Provider.of<MyProgramViewModel>(context, listen: false).getAllItemsFromDB();
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home, color: Colors.black),
              label: '',
              activeIcon: Column(
                children: [
                  const Icon(Icons.home, color: Colors.black),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 7.w,
                    height: 7.h,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list, color: Colors.black),
              label: '',
              activeIcon: Column(
                children: [
                  const Icon(Icons.list, color: Colors.black),
                  SizedBox(height: 5.h),
                  Container(
                    width: 7.w,
                    height: 7.h,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
