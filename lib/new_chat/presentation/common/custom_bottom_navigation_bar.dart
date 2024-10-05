import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app/navigation/tab_navigation_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigationBloc, TabNavigationState>(
      builder: (context, tabState) {
        return BottomNavigationBar(
          currentIndex: tabState.currentIndex,
          onTap: (index) => context
              .read<TabNavigationBloc>()
              .add(TabChanged(newIndex: index)),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
