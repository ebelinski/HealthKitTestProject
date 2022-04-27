import SwiftUI
import HealthKit

struct ContentView: View {
    var body: some View {
        Button("Request HealthKit Access") {
            requestHealthKitAccess()
        }
    }

    func requestHealthKitAccess() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }

        guard let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return
        }

        let healthKitTypesToRead: Set<HKObjectType> = [stepCount]

        HKHealthStore().requestAuthorization(toShare: [], read: healthKitTypesToRead) {
            success, error in
            print(success)
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
