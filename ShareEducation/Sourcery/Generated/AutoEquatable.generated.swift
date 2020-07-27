// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Grade: Equatable {
    public static func ==(lhs: Grade, rhs: Grade) -> Bool {
        guard lhs.id == rhs.id else { return false }
        guard lhs.name == rhs.name else { return false }
       return true
    }
}
