import SwiftUI
import MessageUI

public struct EmailView: UIViewControllerRepresentable {
    

    var email: String

    @Binding var result: Result<MFMailComposeResult, Error>?

    public init(_ email: String, result: Binding<Result<MFMailComposeResult, Error>?>) {
        self.email = email
        self._result = result
    }
    


    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = context.coordinator
        mailComposeViewController.setToRecipients([email])
        mailComposeViewController.setSubject("Hello")
        mailComposeViewController.setMessageBody("Hello from a SwiftUI app!", isHTML: false)
        return mailComposeViewController
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {

    }

    final public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        private let parent: EmailView

        init(_ mailViewController: EmailView) {
            self.parent = mailViewController
        }

        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                parent.result = .success(result)
            }
            guard error == nil else {
                parent.result = .failure(error!)
                return
            }
            controller.dismiss(animated: true)
        }

    }

}
