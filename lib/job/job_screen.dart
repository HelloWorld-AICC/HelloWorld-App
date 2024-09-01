import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/job/components/language_choice_chips.dart';

import 'components/job_card_item_widget.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({
    super.key,
  });

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: Text(
          'jobTitle'.tr(),
          // style: const TextStyle(
          //   fontSize: 24,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.black,
          // ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: SearchBar(
                onChanged: (query) {},
                hintText: 'search'.tr(),
                leading: const Icon(Icons.search),
                backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                padding:
                    WidgetStateProperty.all(const EdgeInsets.only(left: 8)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.rotate_left,
                        size: MediaQuery.of(context).size.width * 0.07),
                    const Expanded(
                      child: LanguageChoiceChips(),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.7),
                    Icon(Icons.filter_list,
                        size: MediaQuery.of(context).size.width * 0.07),
                  ],
                ),
              ),
            ),
            const Divider(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.02),
              child: Text(
                tr('result_count_text'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: JobCardItemWidget(
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
