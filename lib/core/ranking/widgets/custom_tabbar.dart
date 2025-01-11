import 'package:flutter/material.dart';

class MyTabbedPage extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.blue, // Color for the selected tab
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: Colors.black, // Border color for the selected tab
                width: 2,
              ),
            ),
            labelColor: Colors.white, // Text color for the selected tab
            unselectedLabelColor: Colors.black, // Text color for unselected tabs
            tabs: [
              Tab(text: 'All Time'),
              Tab(text: 'This Week'),
              Tab(text: 'This Month'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text('Content for Tab 1')),
              Center(child: Text('Content for Tab 2')),
              Center(child: Text('Content for Tab 3')),
            ],
          ),
        ),
      ],
    );
  }
}