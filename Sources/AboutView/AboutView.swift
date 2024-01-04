import SwiftUI

public struct AboutView<Content: View>: View {

  public var content: () -> Content
  public var name: String?
  public var website: String?
  public var email: String?
  public var twitterId: String?
  public var githubId: String?

  var appName: String {
    return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown App"
  }

  var appDisplayName: String {
    return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? appName
  }

  var appVersion: String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown Version"
  }

  public init(
    _ name: String? = nil,
    website: String? = nil,
    email: String? = nil,
    twitterId: String? = nil,
    githubId: String? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.name = name
    self.content = content
    self.website = website
    self.email = email
    self.twitterId = twitterId
    self.githubId = githubId
  }

  public init(
    _ name: String? = nil,
    website: String? = nil,
    email: String? = nil,
    twitterId: String? = nil,
    githubId: String? = nil
  ) where Content == EmptyView {
    self.init(
      name, website: website, email: email,
      twitterId: twitterId, githubId: githubId, content: { EmptyView() })
  }

  public var body: some View {

    List {
      content()

      Section(header: Text("About \(appDisplayName)")) {
        LabeledContent {
          Text(appVersion)
        } label: {
          HStack {
            Image(systemName: "flag").foregroundColor(.accentColor)
            Text(appName)
          }
        }

        if let email = email {
          LabeledContent {
            SendEmailButton(email, subject: "Feedback from \(appDisplayName)", message: "Hello, I have some feedback for \(appDisplayName).")
          } label: {
            HStack {
              Image(systemName: "envelope").foregroundColor(.accentColor)
              Text("Feedback")
            }
          }
        }
      }

      if name != nil || website != nil || twitterId != nil
        || githubId != nil
      {
        Section(header: Text("About Me")) {
          if let name = name {
            LabeledContent {
              Text(name)
            } label: {
              HStack {
                Image(systemName: "person").foregroundColor(.accentColor)
                Text("Name")
              }
            }
          }

          if let website = website {
            LabeledContent {
              Link(website, destination: URL(string: website)!)
            } label: {
              HStack {
                Image(systemName: "globe").foregroundColor(.accentColor)
                Text("Website")
              }
            }
          }

          if let twitterId = twitterId {
            LabeledContent {
              Link("@\(twitterId)", destination: URL(string: "https://twitter.com/\(twitterId)")!)
            } label: {
              HStack {
                Image(systemName: "at").foregroundColor(.accentColor)
                Text("Twitter")
              }
            }
          }

          if let githubId = githubId {
            LabeledContent {
              Link(githubId, destination: URL(string: "https://github.com/\(githubId)")!)
            } label: {
              HStack {
                Image(systemName: "chevron.left.slash.chevron.right").foregroundColor(.accentColor)
                Text("GitHub")
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
  AboutView(
    "Eson Wong",
    website: "https://blog.esonwong.com",
    email: "esonzero@gmail.com",
    twitterId: "eson000",
    githubId: "esonwong"
  ) {
    Text("Other Content")
  }

}

#Preview {
  AboutView("Eson Wong")
}
