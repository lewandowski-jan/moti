import 'package:flutter/material.dart';
import 'package:moti/core/context.dart';
import 'package:moti/core/positive_integer_input_formatter.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/domain/activity_amount_entity.dart';
import 'package:moti/features/activities/domain/activity_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_type_value_object.dart';
import 'package:moti/features/activities/domain/amount_unit_value_object.dart';
import 'package:moti/features/common/domain/double_value_object.dart';
import 'package:provider/provider.dart';

class AddActivityScreen extends StatelessWidget {
  const AddActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.add_activity_add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: ActivityType.values
                .where((e) => e != ActivityType.invalid)
                .map(ActivityTypeValueObject.fromType)
                .map((e) => _ActivityButton(activityType: e))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _ActivityButton extends StatelessWidget {
  const _ActivityButton({
    required this.activityType,
  });

  final ActivityTypeValueObject activityType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final activitiesCubit = context.read<ActivitiesCubit>();
        int? reps;

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: TextFormField(
                autofocus: true,
                inputFormatters: [PositiveIntegerInputFormatter()],
                keyboardType: TextInputType.number,
                onChanged: (value) => reps = int.tryParse(value),
                decoration: InputDecoration(
                  suffixText: context.l10n.activity_amount_reps,
                  labelText: activityType.getDisplay(context.l10n),
                  border: const OutlineInputBorder(),
                ),
              ),
              content: TextButton(
                onPressed: () {
                  activitiesCubit.logActivity(
                    type: activityType,
                    amount: ActivityAmountEntity(
                      amount: DoubleValueObject(reps?.toDouble()),
                      type: AmountTypeValueObject.from(AmountType.reps),
                      unit: AmountUnitValueObject.from(AmountUnit.reps),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(context.l10n.add_activity_save),
              ),
            );
          },
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        decoration: ShapeDecoration(
          color: context.colors.primary,
          shape: const CircleBorder(),
        ),
        child: Text(
          activityType.getDisplay(context.l10n),
          style: context.textTheme.bodyLarge,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
