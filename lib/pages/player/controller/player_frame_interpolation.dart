enum FrameInterpolationMode {
  off(
    storageValue: 1,
    label: '关闭',
    description: '禁用实时运动插帧',
  ),
  smooth(
    storageValue: 2,
    label: '流畅档 (Oversample)',
    description: '基于 Vulkan 的轻量级运动平滑插帧 (推荐 60FPS)',
  ),
  quality(
    storageValue: 3,
    label: '画质档 (Bicubic)',
    description: '高质量双三次平滑运动插值 (双倍高帧率)',
  );

  const FrameInterpolationMode({
    required this.storageValue,
    required this.label,
    required this.description,
  });

  final int storageValue;
  final String label;
  final String description;

  static FrameInterpolationMode fromStorageValue(int value) {
    return FrameInterpolationMode.values.firstWhere(
      (mode) => mode.storageValue == value,
      orElse: () => FrameInterpolationMode.off,
    );
  }
}
