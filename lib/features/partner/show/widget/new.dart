import 'package:sukientotapp/core/utils/import/global.dart';

import './show.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            for (int i = 0; i < 3; i++)
              Show(
                code: '$i',
                timestamp: '10 Giờ',
                price: '10 VND',
                clientName: 'Client $i',
                category: 'Category $i',
                event: 'Event $i',
                date: '0${i + 1}-02-2026',
                startTime: '10:00',
                endTime: '12:00',
                address: 'Address $i',
                note: 'Note $i',
                currentStatus: 'pending',
              ),
          ],
        ),
      ),
    );
  }
}
