import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';

import 'package:novo_cogni/modules/task_screen/task_screen_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants/enums/module_enums.dart';
import '../../constants/enums/task_enums.dart';
import '../widgets/music_visualizer.dart';
import 'countdown_timer.dart';

class TaskScreen extends GetView<TaskScreenController> {
  TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = controller.scrollController;

    final Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            final evalController = Get.find<EvaluationController>();
            evalController.markModuleAsCompleted(
                controller.moduleInstance.value!.moduleInstanceID!);

            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(
        () {
          final hasImagePath =
              controller.currentTaskEntity.value?.imagePath != null;
          if (hasImagePath) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _scrollDown(scrollController));
          }

          return hasImagePath
              ? buildImageContent(context, windowSize, scrollController)
              : buildContent(context, windowSize);
        },
      ),
    );
  }

  void _scrollDown(ScrollController scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        100.0, // Adjust this value as needed
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget buildContent(BuildContext context, Size windowSize) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (controller.isModuleCompleted.isTrue) {
              return TaskCompletedWidget(onNavigateBack: () {
                final evalController = Get.find<EvaluationController>();
                evalController.markModuleAsCompleted(
                    controller.moduleInstance.value!.moduleInstanceID!);
                Get.back();
              });
            } else if (controller.currentTaskInstance.value != null) {
              var mode = controller.taskMode.value;
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width * 0.30)),
                    child: CustomLinearPercentIndicator(
                      current: controller.currentTaskIndex.value,
                      total: controller.totalTasks.value,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${controller.currentTaskEntity.value?.title ?? 'Unknown'}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child:
                          buildInterfaceBasedOnMode(context, mode, windowSize)),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: buildAccordion(context)),
        )
      ],
    );
  }

  Widget buildInterfaceBasedOnMode(
      BuildContext context, TaskMode mode, Size windowSize) {
    var controller = Get.find<TaskScreenController>();
    var isTestOnly = controller.isTestOnly.value;
    return Column(
      children: [
        buildGeneralInterface(context, windowSize),
        mode == TaskMode.play
            ? buildAudioPlayerInterface(context)
            : isTestOnly
                ? buildAudioRecorderTestingInterface(context)
                : mode == TaskMode.record
                    ? buildAudioRecorderInterface(context)
                    : Container(),
      ],
    );
  }

  Widget buildGeneralInterface(BuildContext context, Size windowSize) {
    return SizedBox(
      width: 880,
      child: Column(
        children: [
          if (controller.mayRepeatPrompt.isFalse) ...[
            Container(
              width: 400,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.redAccent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  "Esse áudio só poderá ser ouvido uma vez",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
          CountdownTimer(
            countdownTrigger: controller.countdownTrigger,
            initialDurationInSeconds:
                controller.currentTaskEntity.value!.timeForCompletion,
            onTimerComplete: _onTimeCompleted,
          ),
          Player(controller: controller, windowSize: windowSize),
        ],
      ),
    );
  }

  Widget buildAudioPlayerInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: windowSize.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: windowSize.width * 0.2,
                    ),
                    CustomIconButton(
                        iconData: Icons.close,
                        label: "Pular",
                        onPressed: () => controller.skipCurrentTask(),
                        isActive: true.obs,
                        displayMessage: "Atividade Pulada",
                        confirmationMessage: "Realmente deseja pular?"),
                    CustomIconButton(
                        iconData: Icons.check,
                        label: "Confirm",
                        onPressed: () => controller.onCheckButtonPressed(),
                        isActive: controller.isCheckButtonEnabled,
                        confirmationMessage:
                            "Confirmar e ir para a próxima tarefa?",
                        displayMessage: "Atividade Concluída"),
                    // EdCheckIconButton(
                    //   iconData: Icons.check,
                    //   label: "Confirm",
                    //   onPressed: () {
                    //     controller.onCheckButtonPressed();
                    //   },
                    //   isActive: controller
                    //       .isCheckButtonEnabled, // Pass the RxBool directly
                    // )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget buildAudioRecorderInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    final recorderInterfaceHeight = windowSize.height * 0.40;
    final TaskScreenController controller = Get.find<TaskScreenController>();

    var AudioRecorderinterfaceContent = [
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // Space out items equally
        crossAxisAlignment: CrossAxisAlignment.center,
        // Vertically center items
        children: [
          CustomIconButton(
              iconData: Icons.close,
              label: "Pular",
              onPressed: () => controller.skipCurrentTask(),
              isActive: true.obs,
              confirmationMessage: "Realmente deseja pular?",
              displayMessage: "Atividade Pulada"),
          CustomRecordingButton(controller: controller),
          CustomIconButton(
              iconData: Icons.check,
              label: "Confirm",
              onPressed: () => controller.onCheckButtonPressed(),
              isActive: controller.isCheckButtonEnabled,
              confirmationMessage: "Confirmar e ir para a próxima tarefa?",
              displayMessage: "Atividade Concluída"),
        ],
      ),
      Flexible(
        flex: 6,
        child: Container(
          width: 300,
          child: SizedBox(
            height: 200,
            child: MusicVisualizer(
              isPlaying: controller.isRecording.value,
              barCount: 30,
              barWidth: 2,
              activeColor: Colors.red,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: CustomIconButton(
            iconData: Icons.close,
            label: "Pular",
            onPressed: () => controller.skipCurrentTask(),
            isActive: true.obs,
            displayMessage: "Atividade Pulada",
            confirmationMessage: "Realmente deseja pular?"),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Container(
        height: recorderInterfaceHeight,
        // color: Colors.pink,
        child: Center(
          // Center the row

          child: Column(
            children: AudioRecorderinterfaceContent,
          ),
        ),
      ),
    );
  }

  Widget buildAudioRecorderTestingInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    final recorderInterfaceHeight = windowSize.height * 0.40;
    final TaskScreenController controller = Get.find<TaskScreenController>();

    var AudioRecorderinterfaceContent = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // Space out items equally
        crossAxisAlignment: CrossAxisAlignment.center,
        // Vertically center items
        children: [
          CustomIconButton(
              iconData: Icons.close,
              label: "Pular",
              onPressed: () => controller.skipCurrentTask(),
              isActive: true.obs,
              confirmationMessage: "Realmente deseja pular?",
              displayMessage: "Atividade Pulada"),
          CustomRecordingTestingButton(controller: controller),
          CustomPlayTestingButton(controller: controller),
          CustomIconButton(
              iconData: Icons.check,
              label: "Confirm",
              onPressed: () => controller.onCheckButtonPressed(),
              isActive: controller.isCheckButtonEnabled,
              confirmationMessage: "Confirmar e ir para a próxima tarefa?",
              displayMessage: "Atividade Concluída"),
        ],
      ),
      Flexible(
        flex: 6,
        child: Container(
          width: 300,
          child: SizedBox(
            height: 200,
            child: MusicVisualizer(
              isPlaying: controller.isRecording.value,
              barCount: 30,
              barWidth: 2,
              activeColor: Colors.red,
            ),
          ),
        ),
      )
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Container(
        height: recorderInterfaceHeight,
        // color: Colors.pink,
        child: Center(
          // Center the row

          child: Column(
            children: AudioRecorderinterfaceContent,
          ),
        ),
      ),
    );
  }

  Widget buildAudioRecorderInterfaceForImageTask(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    final recorderInterfaceHeight = windowSize.height * 0.40;
    final TaskScreenController controller = Get.find<TaskScreenController>();

    var AudioRecorderinterfaceContent = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // Space out items equally
        crossAxisAlignment: CrossAxisAlignment.center,
        // Vertically center items
        children: [
          CustomIconButton(
              iconData: Icons.close,
              label: "Pular",
              confirmationMessage: "Realmente deseja pular?",
              onPressed: () => controller.skipCurrentTask(),
              isActive: true.obs,
              displayMessage: "Atividade Pulada"),
          CustomRecordingButton(controller: controller),
          CustomIconButton(
              iconData: Icons.check,
              label: "Confirm",
              onPressed: () => controller.onCheckButtonPressed(),
              isActive: controller.isCheckButtonEnabled,
              confirmationMessage: "Confirmar e ir para a próxima tarefa?",
              displayMessage: "Atividade Concluída"),
        ],
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Container(
        height: recorderInterfaceHeight,
        // color: Colors.pink,
        child: Center(
          // Center the row

          child: Column(
            children: AudioRecorderinterfaceContent,
          ),
        ),
      ),
    );
  }

  void _onTimeCompleted() async {
    // Play time up sound
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/climbing_fast_sound_effect.mp3'));

    if (controller.isRecording.value) {
      await controller.stopRecording(); // Stop the recording
    }

    // Show time up dialog
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Time Up!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'You have completed the time for this task.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                  audioPlayer.stop(); // Stop the sound if needed
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Disables popup to close by tapping outside
    );
  }

  Widget buildAccordion(BuildContext context) {
    var controller = Get.find<TaskScreenController>();
    return ExpansionTile(
      shape: Border(),
      initiallyExpanded: false,
      // Set to true if you want the accordion to be expanded initially
      title:
          Text("Task Details", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Evaluator: ${'controller.evaluatorName'}",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text("Participant: ${'controller.participantName'}",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text("Module: ${'controller.moduleName'}",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImageContent(BuildContext context, Size windowSize,
      ScrollController scrollController) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (scrollController.hasClients) {
    //     scrollController.animateTo(
    //       500.0,
    //       duration: Duration(milliseconds: 500),
    //       curve: Curves.easeOut,
    //     );
    //   }
    // });
    final String imagePath =
        controller.currentTaskEntity.value?.imagePath ?? '';
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width * 0.30)),
            child: CustomLinearPercentIndicator(
              current: controller.currentTaskIndex.value,
              total: controller.totalTasks.value,
            ),
          ),

          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "${controller.currentTaskEntity.value?.title ?? 'Unknown'}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 20),
          Player(controller: controller, windowSize: windowSize),
          SizedBox(height: 20),
          // Display Image
          Image.asset(
            imagePath,
            width: double.infinity, // Use the full width of the screen
            fit: BoxFit.cover, // Cover the widget's bounds
          ),
          SizedBox(height: 20),
          // Recorder Buttons Container
          buildAudioRecorderInterfaceForImageTask(context),
        ],
      ),
    );
  }
}

class CustomPlayTestingButton extends StatelessWidget {
  final TaskScreenController controller;

  CustomPlayTestingButton({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var isEnabled = controller.isTestingPlaybackButtonEnabled.value;
      var isPlaying = controller.isTestingPlaybackButtonPlaying.value;
      var label = isPlaying ? "Stop" : "Play";
      var icon = isPlaying ? Icons.stop : Icons.play_arrow;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: isEnabled ? Colors.blue.shade100 : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(icon, size: 48),
              color: isEnabled ? Colors.blue : Colors.grey,
              onPressed: isEnabled
                  ? () async {
                      if (isPlaying) {
                        await controller.stopPlayingTest();
                      } else {
                        await controller.playTestRecording();
                      }
                    }
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(label),
          ),
        ],
      );
    });
  }
}

class Player extends StatelessWidget {
  const Player({
    super.key,
    required this.controller,
    required this.windowSize,
  });

  final TaskScreenController controller;
  final Size windowSize;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: Color(0xFFD7D7D7),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  UiStrings.clickOnPlayToListenToTheTask,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          color: controller.shouldDisablePlayButton.value
                              ? Colors.redAccent.shade100
                              : Colors.black54,
                          disabledColor: Colors.redAccent.shade100,
                          iconSize: 48,
                          icon: Icon(controller.isPlaying.value
                              ? Icons.stop
                              : Icons.play_arrow),
                          onPressed: controller.shouldDisablePlayButton.value
                              ? null
                              : () => controller.togglePlay(),
                        ),
                        Text('Play', style: TextStyle(fontSize: 16)),
                        // Subtitle label
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: windowSize.width * 0.4,
                          height: 80,
                          child: MusicVisualizer(
                            isPlaying: controller.isPlaying.value,
                            barCount: 30, // Example: 30 bars
                            barWidth: 3, // Example: Each bar is 3 pixels wide
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onPressed;
  final RxBool isActive;
  String? displayMessage;
  final String confirmationMessage;

  CustomIconButton(
      {Key? key,
      required this.iconData,
      required this.onPressed,
      required this.isActive,
      required this.label,
      this.displayMessage,
      this.confirmationMessage = "Are you sure?"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(iconData, size: 40),
            // Consistent size with recording button
            color: isActive.value ? Colors.blue : Colors.grey,
            onPressed: isActive.value
                ? () =>
                    _showConfirmationDialog(context) // Show confirmation dialog
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            // Add some space above the label
            child: Text(label, style: TextStyle(fontSize: 12)),
          ),
        ],
      );
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text(confirmationMessage),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                onPressed(); // Execute the provided onPressed action

                displayMessage != null
                    ? Get.snackbar(
                        "Ação", // Title
                        displayMessage!, // Message
                        snackPosition: SnackPosition.BOTTOM,
                        // Position of the snackbar
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                        borderRadius: 20,
                        margin: EdgeInsets.all(15),
                        duration: Duration(milliseconds: 1000),
                        // Duration of the snackbar
                        isDismissible: true,
                        // Allow the snackbar to be dismissed
                        dismissDirection:
                            DismissDirection.horizontal, // Dismiss direction
                      )
                    : null;
              },
            ),
          ],
        );
      },
    );
  }
}

class CustomRecordingButton extends StatelessWidget {
  final TaskScreenController controller;

  CustomRecordingButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var label = controller.isRecording.value ? "Parar" : "Gravar";
      var message = controller.isRecording.value
          ? "Gravação parada."
          : "Iniciando Garavção";

      return Column(
        mainAxisSize: MainAxisSize.min, // Use the minimum space available
        children: [
          Container(
            width: 100, // Consistent size with other buttons
            height: 100, // Consistent size with other buttons
            decoration: BoxDecoration(
              color: controller.isRecordButtonEnabled.value
                  ? (controller.isRecording.value
                      ? Colors.redAccent.shade100
                      : Colors.blue.shade100)
                  : Colors.grey.shade400, // Grey color for disabled state
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(
                controller.isRecording.value ? Icons.stop : Icons.mic,
                size: 80, // Adjust the size of the icon if necessary
              ),
              color: controller.isRecordButtonEnabled.value
                  ? (controller.isRecording.value ? Colors.red : Colors.blue)
                  : Colors.grey, // Grey icon for disabled state
              onPressed: controller.isRecordButtonEnabled.value
                  ? () async {
                      if (controller.isTestOnly.isTrue) {
                        controller.stopTestingRecording();
                      } else if (controller.isRecording.value) {
                        await controller.stopRecording();
                      } else {
                        await controller.startRecording();
                      }

                      Get.snackbar("Ação", message,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(milliseconds: 1500));
                    }
                  : null, // Disable the button if isRecordButtonEnabled is false
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            // Space between icon and text
            child: Text(label,
                style: TextStyle(fontSize: 16)), // Use the variable label
          ),
        ],
      );
    });
  }
}

class CustomRecordingTestingButton extends StatelessWidget {
  final TaskScreenController controller;

  CustomRecordingTestingButton({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var isEnabled = controller.isTestingRecordButtonEnabled.value;
      var isRecording = controller.isRecording.value;
      var icon = isRecording ? Icons.stop : Icons.mic;
      var color =
          isEnabled ? (isRecording ? Colors.red : Colors.blue) : Colors.grey;
      var label = isRecording ? "Stop Recording" : "Start Recording";

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1), // Lighter shade for background
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(icon, size: 48),
              color: color,
              onPressed: isEnabled
                  ? () async {
                      if (isRecording) {
                        await controller.stopTestingRecording();
                      } else {
                        await controller.startTestingRecording();
                      }
                    }
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(label),
          ),
        ],
      );
    });
  }
}

class NumericProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const NumericProgressIndicator({
    Key? key,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$current / $total',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class TaskCompletedWidget extends StatelessWidget {
  final VoidCallback onNavigateBack;

  const TaskCompletedWidget({
    Key? key,
    required this.onNavigateBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 120,
            color: Colors.green,
          ),
          Text(
            'All tasks completed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNavigateBack,
            child: Text('Go Back'),
          ),
        ],
      ),
    );
  }
}

class CustomLinearPercentIndicator extends StatelessWidget {
  final int current;
  final int total;

  const CustomLinearPercentIndicator({
    Key? key,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the percent value
    final double percent = total != 0 ? (current - 1) / total : 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          LinearPercentIndicator(
            lineHeight: 20.0,
            percent: percent,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
            barRadius: const Radius.circular(10),
          ),
          Text(
            '${current - 1}/ $total',
            style: TextStyle(
              color: Colors.black, // Color that contrasts with the bar color
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
