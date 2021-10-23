# Define the wiki options
wiki_options = {
  # universal_toc: true,
  index_page: "Netpress%20Wiki",
  h1_title: true,
  user_icons: "gravatar",
  live_preview: false,
  allow_uploads: true,
  per_page_uploads: false,
  allow_editing: true,
  css: false,
  js: false,
  mathjax: true,
  emoji: true,
  show_all: true
}

# Send the wiki options to the Gollum app
Precious::App.set(:wiki_options, wiki_options)

# https://github.com/gollum/gollum/issues/1743#issuecomment-883426141
module OverrideMyPrecious
  def commit_message
    email = request.get_header("HTTP_X_EMAIL") || request.env["X-Email"] || "nobody@netpress.com"
    name = email.split("@").first
    msg = params[:message].nil? || params[:message].empty? ? "[no message]" : params[:message]
    {message: msg, name: name, email: email}
  end

  Precious::App.prepend self
end
