# Gollum Wiki OAuth

We want to give our employees — all GSuite users but not Github users — access to a GitHub style wiki.
Within Gollum, all commits can be made by the git user (from OAuth).

## Special thanks

Installing `Nginx`, `Let's Encrypt ` and `Gollum` are straight forward, but setting up the `OAuth2 Proxy`
was a bit tricky. Getting this working together would not have been possible without the excellent Gollum setup guide from
[Hitesh Jethva](https://www.linkedin.com/in/hitesh-jethva/) and some OAuth advise and assistance from
[Ahmed Musaad](https://www.linkedin.com/in/ahmedmusaad/).

## Required files

This repo contains the files for Gollum Wiki:

- Configuration for Gollum (installed at /etc/gollum/config.rb).<br>
  We added a module to to set the commit message (name and email) from the headers passed back from Nginx.

- Nginx configuration for Gollum (installed at /etc/nginx/conf.d/gollum.conf).<br>
  We set a favicon, configure the `/oauth` path for oauth2_proxy, and set the `X-Email` and `X-Access-Token` headers.
  
- OAuth Proxy Config (installed at /opt/oauth2_proxy/oauth2_proxy.cfg).<br>
  We set pass_user_headers, pass_access_token, set_xauthrequest all to true se we can access the user's email address.

- Gollum Systemd Services (installed at /etc/systemd/system/gollum.service).<br>
  We set the `ref` flag to `wiki` so the Overview page says `Overview of wiki` instead of `Overview of master`.

- Oauth2 Proxy Systemd Services (installed at /etc/systemd/system/oauth_proxy.service).<br>
  This is a standard configurtion from the guide we used.

## Server setup

Getting all the dependencies installed can be a pain, but `apt install ruby-gollum-lib` takes care of that on Debian.
We followed [this guide](https://www.atlantic.net/vps-hosting/how-to-setup-a-github-style-wiki-using-gollum-on-debian-10/)
to get it installed as a service with NGINX in front (so we can install other services). We did make a change,
by setting up the wiki in the home dir of use gollum, and we run the web stack as that user as well.
Only NGINX needs to run as root (as it listens on port 80). We also renamed the main branch `wiki`.

When setting up `Client ID for Web application` within `OAuth Client Credentials` on GCP,
it's critical to setup the following `Authorized redirect URI`
```
https://wiki.netpress.com/oauth2/callback
```

We don't need to authorize, just authenticate. We can use an
[NGINX OAuth Proxy](https://dev.to/ahmedmusaad/add-google-authentication-to-any-website-using-nginx-and-oauth-proxy-259l).
Use [let's encrypt](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-debian-10)
with  `certbot` to generate keys, then configure [oauth2_proxy](https://github.com/oauth2-proxy/oauth2-proxy).

![](http://yuml.me/diagram/scruffy/class/[GSuite%20Employees%20{bg:wheat}]->[OAuth%20Proxy]->[Credentials;OAuth%20Endpoint{bg:green}]->[OAuth%20Proxy]->[Compute%20Engine;Nginx%20&%20Gollum])
