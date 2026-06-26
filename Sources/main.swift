import SwiftUI

struct ContentView: View {
    @State private var statusMessage = "Ready"
    @State private var isBoosting = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Performance Booster")
                .font(.title)
                .bold()

            Text(statusMessage)
                .foregroundColor(.secondary)

            Button(action: boostPerformance) {
                Text(isBoosting ? "Boosting..." : "Boost Now")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isBoosting ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(isBoosting)
            .padding(.horizontal)
        }
        .padding()
    }

    func boostPerformance() {
        isBoosting = true
        statusMessage = "Clearing caches..."

        DispatchQueue.global(qos: .userInitiated).async {
            URLCache.shared.removeAllCachedResponses()
            clearTempFiles()

            DispatchQueue.main.async {
                statusMessage = "Done — caches cleared."
                isBoosting = false
            }
        }
    }

    func clearTempFiles() {
        let tempDir = NSTemporaryDirectory()
        let fileManager = FileManager.default
        if let files = try? fileManager.contentsOfDirectory(atPath: tempDir) {
            for file in files {
                try? fileManager.removeItem(atPath: tempDir + file)
            }
        }
    }
}

@main
struct PerfBoosterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
