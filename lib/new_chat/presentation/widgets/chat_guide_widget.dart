import 'package:flutter/material.dart';

import '../../../design_system/hello_colors.dart';
import '../icon_data.dart';

class ChatGuideWidget extends StatelessWidget {
  const ChatGuideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
            color: Color(0xffF4F4F4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "상담 받고 싶은 주제를 선택해주세요",
                  style: TextStyle(
                      color: HelloColors.gray,
                      fontFamily: 'SB AggroOTF',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: initial_icons.length,
                    itemBuilder: (context, index) {
                      final iconType = initial_icons.keys.elementAt(index);
                      final iconData = initial_icons[iconType]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                iconData.iconPath,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                iconData.title,
                                style: TextStyle(
                                  color: HelloColors.mainColor1,
                                  fontFamily: 'SB AggroOTF',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              color: HelloColors.gray,
                              width: 150,
                              height: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
