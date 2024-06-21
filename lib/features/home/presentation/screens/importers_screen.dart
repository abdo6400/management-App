import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/app_components/client_card_compenent.dart';
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/importers_bloc/importers_bloc.dart';

class ImportersScreen extends StatelessWidget {
  const ImportersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportersBloc, ImportersState>(
      builder: (contImt, state) {
        if (state is ImportersClientsLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ImportersClientsErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ImportersClientsLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!",
                title: AppStrings.noImportersBeAddedYet,
                subTitle: "");
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: state.clients
                      .map((e) => ClientCardComponent(
                            client: e,
                            enableEditing: true,
                           
                          ))
                      .toList(),
                ),
              ),
              OptionsCardComponent(
                clients: state.clients,
              ),
              SizedBox(
                height: AppValues.sizeHeight * 10,
              )
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
