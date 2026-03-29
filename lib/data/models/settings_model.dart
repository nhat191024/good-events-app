class SettingsModel {
  final String hotline;
  final String zalo;

  const SettingsModel({required this.hotline, required this.zalo});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      hotline: (json['hotline'] as String?) ?? '',
      zalo: (json['zalo'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'hotline': hotline, 'zalo': zalo};

  factory SettingsModel.empty() => const SettingsModel(hotline: '', zalo: '');
}
