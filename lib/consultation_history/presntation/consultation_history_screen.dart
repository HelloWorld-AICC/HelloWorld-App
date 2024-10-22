import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world_mvp/common/presentation/common_appbar.dart';

class ConsultationHistoryScreen extends StatelessWidget {
  const ConsultationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(),
      body: Padding(
        padding: EdgeInsets.only(top: 11, left: 24, right: 24),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 9, top: 11, right: 9, bottom: 10),
                
              );
            }),
      ),
    );
  }
}
