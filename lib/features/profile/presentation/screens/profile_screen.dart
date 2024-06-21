import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/profile_bloc.dart';

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
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ProfileErrorState) {
              return Text(state.message);
            } else if (state is ProfileLoadedState) {
              if (state.tanks.isEmpty) {
                return DefaultMessageCard(
                    sign: "!", title: AppStrings.tank, subTitle: "");
              }
              return Expanded(
                child: GridView.builder(
                  itemCount: state.tanks.values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: AppValues.sizeHeight * 100),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: AppValues.marginWidth * 10,
                            vertical: AppValues.marginHeight * 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppValues.radius * 10),
                          color: AppColors.primary,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: AppValues.paddingHeight * 5),
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.white,
                              child: Text("${state.tanks.keys.elementAt(index)}"
                                  .toString()),
                            ),
                            title: RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: AppColors.white),
                                    children: [
                                      TextSpan(
                                          text:
                                              "${state.tanks.values.elementAt(index)}"
                                                  .toString()),
                                      const TextSpan(text: " "),
                                      TextSpan(
                                          text: AppStrings.kilo.tr(context)),
                                    ]))));
                  },
                ),
              );
            }
            return CircularProgressIndicator();
          },
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
