import AppKit
import os

struct Accessibility {
  private static let logger = Logger(subsystem: "Maccy", category: "Accessibility")

  static var isAllowed: Bool {
    AXIsProcessTrusted()
  }

  static func requestAccess() -> Bool {
    let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
    return AXIsProcessTrustedWithOptions(options)
  }

  static func check() {
    guard isAllowed else {
      logger.warning("Accessibility permission is not granted. Paste functionality may not work.")

      // Request permission with prompt
      if !requestAccess() {
        logger.error("Failed to request accessibility permission.")
      }
      return
    }
  }
}
