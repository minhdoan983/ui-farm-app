update_app_icon:
	fvm dart run flutter_launcher_icons:main

update_splash:
	fvm dart run flutter_native_splash:create

remove_splash:
	fvm dart run flutter_native_splash:remove

gen_assets:
	fluttergen

pub_get:
	fvm flutter pub get

pub_upgrade:
	fvm flutter pub upgrade

analyze:
	fvm flutter analyze --no-pub --suppress-analytics

sync:
	fvm flutter pub get
	fluttergen
	fvm dart run build_runner build --delete-conflicting-outputs
	fvm dart run lean_builder build --dev

build_all:
	fvm dart run lean_builder build --dev
	fvm dart run build_runner build