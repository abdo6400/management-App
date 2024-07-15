
import 'package:flutter/material.dart';
import '../../../../core/utils/app_values.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: AppValues.sizeHeight * 10,
        ),
       
        Divider(),
        /*  SizedBox(
          height: AppValues.sizeHeight * 10,
        ),
        Card(
          elevation: 0.2,
          child: ListTile(
            leading: Icon(Icons.propane_tank_outlined),
            title: Text(AppStrings.tank.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: AppValues.font * 25)),
          ),
        ),*/
      ],
    ));
  }
}
