//
//  FLNativeViewFactory.swift
//  Runner
//
//  Created by Uncle Charlie on 2024/8/16.
//

import Foundation
import Flutter

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger
  
  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }
  
  func create(withFrame frame: CGRect,
              viewIdentifier viewId: Int64,
              arguments args: Any?) -> FlutterPlatformView {
    return FLNariveView(frame: frame, viewIdentitifer: viewId, arguments: args, binaryMessenger: messenger)
  }
}
