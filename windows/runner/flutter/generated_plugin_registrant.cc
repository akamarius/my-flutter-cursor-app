//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_animate/flutter_animate_plugin_c_api.h>
#include <flutter_map/flutter_map_plugin_c_api.h>
#include <geolocator_windows/geolocator_windows.h>
#include <image_picker_for_web/image_picker_for_web_plugin.h>
#include <url_launcher_windows/url_launcher_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterAnimatePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterAnimatePluginCApi"));
  FlutterMapPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterMapPluginCApi"));
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
  ImagePickerForWebPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ImagePickerForWebPlugin"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
} 