#!/usr/bin/env swift
// Watches for dark mode changes and runs a program with the DARKMODE env flag
// set to 1 or 0
//
// Compile with:
//      swiftc dark-mode-notifier.swift -o dark-mode-notifier
//
// And run the binary directly with the program you want to run on mode change:
//     ./dark-mode-notifier /path/to/program
//
// based on https://github.com/bouk/dark-mode-notify/blob/main/main.swift

import Cocoa

@discardableResult
func shell(_ args: [String]) -> Int32 {
    let task = Process()
    let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    var env = ProcessInfo.processInfo.environment
    env["DARKMODE"] = isDark ? "1" : "0"
    task.environment = env
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.standardError = FileHandle.standardError
    task.standardOutput = FileHandle.standardOutput
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

let args = Array(CommandLine.arguments.suffix(from: 1))

shell(args)

DistributedNotificationCenter.default.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil) { (notification) in shell(args) }

NSWorkspace.shared.notificationCenter.addObserver(
    forName: NSWorkspace.didWakeNotification,
    object: nil,
    queue: nil) { (notification) in shell(args) }

NSApplication.shared.run()
