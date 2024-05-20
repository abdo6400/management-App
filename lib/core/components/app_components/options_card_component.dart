import 'package:baraneq/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../entities/client.dart';

class OptionsCardComponent extends StatelessWidget {
  const OptionsCardComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            backgroundColor: AppColors.nearlyWhite,
            child: Icon(
              Icons.share,
              color: AppColors.primary,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            backgroundColor: AppColors.nearlyWhite,
            child: Icon(
              Icons.print,
              color: AppColors.green,
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: AppColors.nearlyWhite,
              child: Icon(
                Icons.file_download_sharp,
                color: AppColors.error,
              ),
            ))
      ],
    );
  }
}
