import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'component/create_resume_screen.dart';
import 'component/manage_my_resume.screen.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var paddingVal = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'resumeTitle'.tr(),
          style: TextStyle(
            fontSize: 24 * paddingVal / 100,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'autoGenerateResume'.tr()),
            Tab(text: 'manageResume'.tr()),
          ],
          labelStyle: TextStyle(
            fontSize: 16 * paddingVal / 100,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CreateResumeScreen(paddingVal: paddingVal),
          ManageMyResumeScreen(paddingVal: paddingVal),
        ],
      ),
    );
  }
}
