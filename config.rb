# This file can be used to (e.g.):
# - alter certain inner parts of Gollum,
# - extend it with your stuff.
#
# It is especially useful for customizing supported formats/markups. For more information and
# examples:
# - https://github.com/gollum/gollum#config-file
#
# :authorized_users => ["*@netpress.com"],
#

# Define the wiki options
wiki_options = {
  universal_toc: true,
  h1_title: true,
  user_icons: "gravatar",
  live_preview: false,
  allow_uploads: true,
  per_page_uploads: true,
  allow_editing: true,
  css: false,
  js: false,
  mathjax: true,
  emoji: true,
  show_all: true
}

# Send the wiki options to the Gollum app
Precious::App.set(:wiki_options, wiki_options)

module OverrideMyPrecious
  def commit_message
    email = request.get_header("HTTP_X_EMAIL") || request.env["X-Email"] || "nobody@netpress.com"
    name = email.split("@").first
    msg = params[:message].nil? || params[:message].empty? ? "[no message]" : params[:message]
    {message: msg, name: name, email: email}
  end

  Precious::App.prepend self
end
