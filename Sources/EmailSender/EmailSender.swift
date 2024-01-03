// The Swift Programming Language
// https://docs.swift.org/swift-book

import MessageUI
import SwiftUI

public struct SendEmailButton: View {

  public var email: String

  public init(_ email: String) {
    self.email = email
  }

  @State private var isShowingMailView = false
  @State private var result: Result<MFMailComposeResult, Error>? = nil

  public var body: some View {
    VStack {
      Button(action: {
        self.isShowingMailView.toggle()
      }) {
        Text("Send Email")
      }
      .disabled(!MFMailComposeViewController.canSendMail())
    }
    .sheet(isPresented: $isShowingMailView) {
      EmailView(email, result: self.$result)
    }
  }
}

#Preview {
  SendEmailButton("esonzero@gmail.com")
}
