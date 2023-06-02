import 'package:flutter/material.dart';
import 'package:refresh_indicator/widgets/toutiao_refresh_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refresh indicator'),
      ),
      body: Scrollbar(
        child: ToutiaoRefreshIndicator(
          onRefresh: () => Future.delayed(const Duration(seconds: 2)),
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(index.toString()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
