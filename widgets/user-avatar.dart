import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:steelpanel/control/user-info.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
  });

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return UserInfoControll.user_avatar.value != ''
          ? Image.memory(
              // width: 60,
              fit: BoxFit.cover,
              base64Decode(UserInfoControll.user_avatar.value))
          : CircleAvatar(
              child: CachedNetworkImage(
                width: 60,
                height: 60,
                imageUrl:
                    "https://test.ht-hermes.com/avatar/uploads/666fde36865af8.44501279.png",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
    });
  }
}
