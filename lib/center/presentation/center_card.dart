import 'package:flutter/cupertino.dart';

import '../../design_system/hello_colors.dart';
import '../domain/model/center.dart' as center_model;

class CenterCard extends StatelessWidget {
  final center_model.Center center;

  const CenterCard({
    super.key,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Color(0xffB1E099),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    center.status.getOrCrash(),
                    style: const TextStyle(
                      fontFamily: 'SB AggroOTF',
                      color: Color(0xffB1E099),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                center.name.getOrCrash(),
                                style: const TextStyle(
                                  fontFamily: 'SB AggroOTF',
                                  color: HelloColors.mainColor1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                center.address.getOrCrash(),
                                style: const TextStyle(
                                  fontFamily: 'SB AggroOTF',
                                  color: HelloColors.subTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ]),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Image(
                      image: NetworkImage(
                        center.image.getOrCrash() == ""
                            ? "https://dummyimage.com/100x100"
                            : center.image.getOrCrash(),
                      ),
                      width: 100,
                      height: 100,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
