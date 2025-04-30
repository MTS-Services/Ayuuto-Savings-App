import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class CalenderTileWidget extends StatelessWidget {
  const CalenderTileWidget({
    super.key,
    required this.isFirstContainerSelected,
    required this.isSecondContainerSelected,
    required this.selectedDateText,
  });

  final Rx<bool> isFirstContainerSelected;
  final Rx<bool> isSecondContainerSelected;
  final RxString selectedDateText;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          InkWell(
            onTap: () async {
              isFirstContainerSelected.value = true;
              isSecondContainerSelected.value = false;
              final DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              // If a date is selected, print it (or use it in your app)
              if (selectedDate != null) {
                final formattedDate =
                    DateFormat('MMMM yyyy').format(selectedDate);

                selectedDateText.value = formattedDate;
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFirstContainerSelected.value
                    ? Colors.grey.shade100
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: const Icon(Iconsax.calendar_2_copy,
                  color: Colors.black, size: 30),
            ),
          ),
          InkWell(
            onTap: () {
              isFirstContainerSelected.value = false;
              isSecondContainerSelected.value = true;
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSecondContainerSelected.value
                    ? Colors.grey.shade100
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: const Icon(Iconsax.menu_1, color: Colors.black, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
