import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_images.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/features/home/presentation/components/balance_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: AppValues.screenHeight,
          width: AppValues.screenWidth,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                SizedBox(
                  height: AppValues.sizeHeight * 10,
                ),
                const Expanded(flex: 2, child: BalanceComponents()),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppValues.marginWidth * 10),
                    child: ListTile(
                      title: Text(
                        "Client Type",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      leading: GestureDetector(
                          onTap: () {}, child: Icon(Icons.add_circle)),
                    )),
                Divider(),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: AppValues.screenWidth,
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: AppValues.marginWidth * 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppValues.radius * 10)),
                        child: TabBar(
                          tabs: [
                            Tab(
                              text: "importer",
                            ),
                            Tab(
                              text: "exporter",
                            ),
                          ],
                        )),
                  ),
                ),
                Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: AppValues.paddingHeight * 10,
                          right: AppValues.paddingWidth * 10,
                          left: AppValues.paddingWidth * 10),
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemBuilder: (context, index) => SizedBox(
                                height: AppValues.sizeHeight * 100,
                                child: const Card(
                                  color: Colors.amber,
                                )),
                            itemCount: 10,
                          ),
                          ListView.builder(
                            itemBuilder: (context, index) => const Card(),
                            itemCount: 5,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
