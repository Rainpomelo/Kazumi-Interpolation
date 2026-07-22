import 'package:flutter/material.dart';
import 'package:kazumi/bean/appbar/sys_app_bar.dart';
import 'package:kazumi/pages/player/controller/player_frame_interpolation.dart';
import 'package:kazumi/services/storage/storage.dart';
import 'package:card_settings_ui/card_settings_ui.dart';

class FrameInterpolationSettings extends StatefulWidget {
  const FrameInterpolationSettings({super.key});

  @override
  State<FrameInterpolationSettings> createState() =>
      _FrameInterpolationSettingsState();
}

class _FrameInterpolationSettingsState
    extends State<FrameInterpolationSettings> {
  late FrameInterpolationMode frameInterpolationMode;

  @override
  void initState() {
    super.initState();
    frameInterpolationMode = FrameInterpolationMode.fromStorageValue(
      GStorage.getSetting<int>(SettingsKeys.defaultFrameInterpolationMode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.bodyMedium?.fontFamily;
    return Scaffold(
      appBar: const SysAppBar(
        title: Text('⚡ 实时运动插帧 (Vulkan)'),
      ),
      body: SettingsList(
        maxWidth: 1000,
        sections: [
          SettingsSection(
            title: Text(
                '基于 libmpv + Vulkan GPU 算力强插帧，将 24/30FPS 动漫补帧至 60/120FPS 顺滑高帧率',
                style: TextStyle(fontFamily: fontFamily)),
            tiles: [
              for (final mode in FrameInterpolationMode.values)
                SettingsTile<FrameInterpolationMode>.radioTile(
                  title: Text(
                    mode.label,
                    style: TextStyle(fontFamily: fontFamily),
                  ),
                  description: Text(
                    mode.description,
                    style: TextStyle(fontFamily: fontFamily),
                  ),
                  radioValue: mode,
                  groupValue: frameInterpolationMode,
                  onChanged: (FrameInterpolationMode? value) {
                    if (value == null) return;
                    GStorage.putSetting<int>(
                      SettingsKeys.defaultFrameInterpolationMode,
                      value.storageValue,
                    );
                    setState(() {
                      frameInterpolationMode = value;
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
