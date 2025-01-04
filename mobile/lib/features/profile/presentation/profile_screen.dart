import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/context.dart';
import 'package:moti/core/decimal_input_formatter.dart';
import 'package:moti/core/positive_integer_input_formatter.dart';
import 'package:moti/features/measurements/domain/height_entity.dart';
import 'package:moti/features/measurements/domain/measurement_unit_value_object.dart';
import 'package:moti/features/measurements/domain/weight_entity.dart';
import 'package:moti/features/profile/application/profile_cubit.dart';
import 'package:moti/features/profile/domain/gender_value_object.dart';
import 'package:moti/features/settings/settings_screen.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        context.read<ProfileCubit>().init();
        return null;
      },
      [],
    );

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.profile),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () async {
                    final profileCubit = context.read<ProfileCubit>();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextFormField(
                            autofocus: true,
                            initialValue: profileCubit.state.name.getOrNull,
                            onChanged: profileCubit.setName,
                            decoration: InputDecoration(
                              labelText: context.l10n.profile_name,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    );

                    await profileCubit.onProfileSubmitted();
                  },
                  title: Text(
                    context.l10n.profile_name,
                    style: context.textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_right),
                      const SizedBox(width: 8),
                      Text(
                        state.name.getOr('-'),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Divider(color: context.colors.onBackground),
                ListTile(
                  onTap: () async {
                    final profileCubit = context.read<ProfileCubit>();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SettingGroup(
                            value: profileCubit.state.gender,
                            header: context.l10n.profile_gender,
                            options: [
                              GenderValueObject(Gender.male),
                              GenderValueObject(Gender.female),
                            ]
                                .map((e) => (e, e.getDisplay(context.l10n)))
                                .toList(),
                            onChanged: (gender) {
                              profileCubit.setGender(gender);
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    );

                    await profileCubit.onProfileSubmitted();
                  },
                  title: Text(
                    context.l10n.profile_gender,
                    style: context.textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_right),
                      const SizedBox(width: 8),
                      Text(
                        state.gender.getDisplay(context.l10n),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Divider(color: context.colors.onBackground),
                ListTile(
                  onTap: () async {
                    final profileCubit = context.read<ProfileCubit>();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextFormField(
                            inputFormatters: [
                              DecimalInputFormatter(),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            autofocus: true,
                            initialValue: profileCubit
                                .state.height.amount.getOrNull
                                ?.toString(),
                            onChanged: (value) => profileCubit.setHeight(
                              HeightEntity(
                                amount: double.tryParse(
                                  value.replaceFirst(',', '.'),
                                ),
                                unit: MeasurementUnit.cm,
                              ),
                            ),
                            decoration: InputDecoration(
                              suffixText: context.l10n.height_unit_cm,
                              labelText: context.l10n.profile_height,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    );

                    await profileCubit.onProfileSubmitted();
                  },
                  title: Text(
                    context.l10n.profile_height,
                    style: context.textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_right),
                      const SizedBox(width: 8),
                      Text(
                        state.height.getDisplay(
                          context.l10n,
                          MeasurementUnit.cm,
                        ),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Divider(color: context.colors.onBackground),
                ListTile(
                  onTap: () async {
                    final profileCubit = context.read<ProfileCubit>();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextFormField(
                            inputFormatters: [
                              DecimalInputFormatter(),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            autofocus: true,
                            initialValue: profileCubit
                                .state.weight.amount.getOrNull
                                ?.toString(),
                            onChanged: (value) => profileCubit.setWeight(
                              WeightEntity(
                                amount: double.tryParse(
                                  value.replaceFirst(',', '.'),
                                ),
                                unit: MeasurementUnit.kg,
                              ),
                            ),
                            decoration: InputDecoration(
                              suffixText: context.l10n.weight_unit_kg,
                              labelText: context.l10n.profile_weight,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    );

                    await profileCubit.onWeightSubmitted();
                  },
                  title: Text(
                    context.l10n.profile_weight,
                    style: context.textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_right),
                      const SizedBox(width: 8),
                      Text(
                        state.weight.getDisplay(
                          context.l10n,
                          MeasurementUnit.kg,
                        ),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Divider(color: context.colors.onBackground),
                ListTile(
                  onTap: () async {
                    final profileCubit = context.read<ProfileCubit>();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextFormField(
                            autofocus: true,
                            inputFormatters: [PositiveIntegerInputFormatter()],
                            keyboardType: TextInputType.number,
                            initialValue: profileCubit.state.dailyGoal.getOrNull
                                ?.toString(),
                            onChanged: (value) =>
                                profileCubit.setDailyGoal(int.tryParse(value)),
                            decoration: InputDecoration(
                              suffixText: context.l10n.mt,
                              labelText: context.l10n.profile_daily_goal,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    );

                    await profileCubit.onProfileSubmitted();
                  },
                  title: Text(
                    context.l10n.profile_daily_goal,
                    style: context.textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_right),
                      const SizedBox(width: 8),
                      Text(
                        state.dailyGoal.getOrNull != null
                            ? '${state.dailyGoal.getOrNull} ${context.l10n.mt}'
                            : '-',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
