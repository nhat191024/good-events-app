import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class ChatInput extends StatelessWidget {
  final MessageController controller;
  
  const ChatInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.selectedFiles.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.selectedFiles.length,
                itemBuilder: (context, index) {
                  // final file = controller.selectedFiles[index]; 
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.file_present)),
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller.messageController,
            maxLines: 4,
            minLines: 1,
            decoration: InputDecoration(
              hintText: "type_a_message".tr,
              hintStyle: const TextStyle(color: AppColors.lightMutedForeground, fontSize: 16),
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: AppColors.lightBorder, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: AppColors.lightBorder, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: AppColors.lightBorder, width: 1.0),
              ),
              filled: true,
              fillColor: AppColors.white,
              // prefixIcon: IconButton(
              //   icon: const Icon(Icons.attach_file, color: AppColors.lightForeground),
              //   onPressed: () {
              //     controller.pickFiles();
              //   },
              // ),
              suffixIcon: Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    controller.sendMessage();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
