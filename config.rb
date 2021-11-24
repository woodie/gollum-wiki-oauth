@@authorized_users = %w[ahmed hitesh woodie]

# Define the wiki options
wiki_options = {
  # :template_dir => "/home/gollum/gollum/lib/gollum/templates/",
  index_page: "Netpress%20Wiki",
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

class Precious::App
  before do
    email = request.get_header("HTTP_X_EMAIL") || request.env["X-Email"] || "nobody@netpress.com"
    name = email.split("@").first
    halt 403, "Sorry, nothing for you here." unless @@authorized_users.include? name
    session["gollum.author"] = {name: name, email: email}
  end
end
