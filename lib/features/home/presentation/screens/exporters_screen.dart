
import 'package:baraneq/core/components/default_components/default_message_card.dart';
import 'package:baraneq/features/home/presentation/bloc/exporter_bloc/exporter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/app_components/client_card_compenent.dart';
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/utils/app_strings.dart';


class ExportersScreen extends StatelessWidget {
  const ExportersScreen({super.key});
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExporterBloc, ExporterState>(
      builder: (context, state) {
        if (state is ExportersClientsLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ExportersClientsErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ExportersClientsLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!",
                title: AppStrings.noExportersBeAddedYet,
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
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
