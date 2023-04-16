import Foundation
import ShellKit

extension Array {

    mutating func popFirst() -> Element? {
        isEmpty ? nil : removeFirst()
    }
}

@main
struct Feather {

    // echo $?
    static func main() throws {
        var args = CommandLine.arguments
        
        if args.count == 1 {
            
            let reset = "\u{001B}[0;0m"
            let bold = "\u{001B}[0;1m"
            let magenta = "\u{001B}[0;35m"
            
            let output = #"""
            \#(magenta)
            Welcome to Feather!

            \#(bold)Subcommands:
            
              feather test     \#(reset)Test stuff

            Use \#(bold)`feather --help`\#(reset) for descriptions of available options and flags.
            
            Use \#(bold)`feather help <subcommand>`\#(reset) for more information about a subcommand.
            
            """#
            print(output)
            exit(EXIT_SUCCESS)
        }

        guard
            let path = args.popFirst(),
            let subcommand = args.popFirst()
        else {
            fatalError("Invalid command invocation.")
        }
        let argString = args.map { "\"" + $0 + "\"" }.joined(separator: " ")
        
        let base = URL(fileURLWithPath: path).lastPathComponent
        let cmd = base + "-" + subcommand
        let shellCommand = cmd + " " + argString

        let shell = Shell()
        do {
            let res = try shell.run(shellCommand)
            print(res)
            exit(EXIT_SUCCESS)
        }
        catch let error as ShellKit.Shell.Error {
            switch error {
            case let .generic(code, message):
                if code == 127 {
                    print("error: unable to invoke subcommand: \(cmd) (No such file or directory)")
                    exit(2)
                }
                print(message)
                exit(Int32(code))
            case .outputData:
                print(error.localizedDescription)
                exit(EXIT_FAILURE)
            }
        }
        catch {
            exit(EXIT_FAILURE)
        }
    }
}
