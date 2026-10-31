// Usage: swift set-defaults.swift <app path> <extension>...
// Makes the app the default for each extension. duti can't do this: it fails on
// extensions macOS has no registered type for (.rs, .go, .lua, .toml).

import AppKit
import UniformTypeIdentifiers

let app = URL(fileURLWithPath: CommandLine.arguments[1])
var failed = 0

for ext in CommandLine.arguments.dropFirst(2) {
    guard let type = UTType(filenameExtension: ext) else {
        print("  ⚠️  .\(ext): no file type")
        failed += 1
        continue
    }
    // Launch Services briefly rejects some types right after the app is rebuilt
    var lastError: Error?
    for _ in 1...5 {
        lastError = await withCheckedContinuation { continuation in
            NSWorkspace.shared.setDefaultApplication(at: app, toOpen: type) { error in
                continuation.resume(returning: error)
            }
        }
        if lastError == nil { break }
        try? await Task.sleep(nanoseconds: 500_000_000)
    }
    if let error = lastError {
        print("  ⚠️  .\(ext): \(error.localizedDescription)")
        failed += 1
    }
}

exit(failed == 0 ? 0 : 1)
