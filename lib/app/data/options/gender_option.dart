import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:flutter/material.dart';

class GenderOption {
  static List<DropdownMenuItem<String>> getOptionDropdown() => [
        DropdownMenuItem(
          value: 'MALE',
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 30,
                child: Image.asset(AppAssets.boy),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text('Nam'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'FEMALE',
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 30,
                child: Image.asset(AppAssets.girl),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text('Nữ'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: 'OTHER',
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 30,
                child: Image.asset(AppAssets.avatar),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text('Khác'),
            ],
          ),
        )
      ];
}
