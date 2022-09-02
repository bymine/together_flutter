import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:together_flutter/src/controllers/file/detail_folder_controller.dart';
import 'package:together_flutter/src/controllers/file/file_controller.dart';
import 'package:together_flutter/src/models/file.dart';
import 'package:together_flutter/src/utils.dart';

class DetailFolderPage extends GetView<DetailFolderController> {
  const DetailFolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FolderDetailView(folder: controller.currentFolder.value),
              Container(
                padding:
                    EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.currentFolder.value.fileMap.keys.first} 파일",
                      style: const TextStyle(fontSize: 20),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.currentFolder.value.files.length,
                        itemBuilder: (context, index) => FileListTile(
                            fileData:
                                controller.currentFolder.value.files[index]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FileListTile extends GetView<FileController> {
  final ProjectFile fileData;
  const FileListTile({Key? key, required this.fileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: fileDecoration(fileData.fileType),
          child: fileIcon(fileData.fileType),
        ),
        title: Text(fileData.title),
        subtitle: Text(
          "${fileData.mbSize.toStringAsFixed(3)}MB  ${Utils.formatDate(fileData.date.toDate(), "-")}",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        trailing: DropdownButton(
            icon: const Icon(Icons.more_vert),
            underline: Container(),
            items: controller.fileOption
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == "다운로드") {
                controller.downloadFile(fileData);
              } else {
                controller.deleteFile(fileData);
              }
            }));
  }

  Icon fileIcon(UploadType fileExt) {
    switch (fileExt) {
      case UploadType.photo:
        return const Icon(
          LineIcons.image,
          size: 18,
          color: Colors.green,
        );
      case UploadType.document:
        return const Icon(
          LineIcons.fileInvoice,
          size: 18,
          color: Colors.purple,
        );
      case UploadType.media:
        return LineIcon(
          LineIcons.video,
          size: 18,
          color: Colors.orange,
        );
    }
  }

  BoxDecoration fileDecoration(UploadType fileExt) {
    switch (fileExt) {
      case UploadType.document:
        return BoxDecoration(
            color: Colors.purple.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8)));
      case UploadType.photo:
        return BoxDecoration(
            color: Colors.green.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8)));

      case UploadType.media:
        return BoxDecoration(
            color: Colors.orange.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8)));
    }
  }
}

class FolderDetailView extends StatelessWidget {
  const FolderDetailView({
    Key? key,
    required this.folder,
  }) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
      height: Get.height * 0.4,
      decoration: const BoxDecoration(
          color: Color(0xff252839),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    LineIcons.angleLeft,
                    color: Colors.white,
                  )),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                folder.icon,
                color: folder.color,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                folder.fileMap.keys.first,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                folder.folderSize.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Mb",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "30 Mb",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Used",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        Text(
                          "Free",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          LinearPercentIndicator(
            lineHeight: 8,
            barRadius: const Radius.circular(4),
            backgroundColor: Colors.white54,
            percent: folder.folderSize / 30,
            animation: true,
            progressColor: folder.color,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
