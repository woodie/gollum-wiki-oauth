# Gollum Wiki OAuth

We want to give our employees — all GSuite users but not Github users — access to a GitHub style wiki.
Within Gollum, all commits can be made by the git user (from OAuth).

We'd like to eventually have an automated setup when possible and maybe even create a 
[stateless container image](https://github.com/gollum/gollum/issues/1767)
Installing `Nginx`, `Let's Encrypt ` and `Gollum` are straight forward,
but setting up the OAuth proxy was a bit tricky. Special thanks to our new friends
for helping out with this.

### The files

This repo contains the files for Gollum Wiki:

- Configuration for Gollum:<br>
  /etc/gollum/config.rb

- Nginx configuration for Gollum:<br>
  /etc/nginx/conf.d/gollum.conf

- OAuth Proxy Config<br>
  /opt/oauth2_proxy/oauth2_proxy.cfg

- Systemd Services<br>
  /etc/systemd/system/gollum.service<br>
  /etc/systemd/system/oauth_proxy.service

### Background

Getting all the dependencies installed can be a pain, but `apt install ruby-gollum-lib` takes care of that on Debian.
We followed [this guide](https://www.atlantic.net/vps-hosting/how-to-setup-a-github-style-wiki-using-gollum-on-debian-10/)
to get it installed as a service with NGINX in front (so we can install other services). We did make a change,
by setting up the wiki in the home dir of use gollum, and we run the web stack as that user as well.
Only NGINX needs to run as root (as it listens on port 80).

We don't need to authorize, just authenticate. We can use an
[NGINX OAuth Proxy](https://dev.to/ahmedmusaad/add-google-authentication-to-any-website-using-nginx-and-oauth-proxy-259l).
Use [let's encrypt](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-debian-10)
with  `certbot` to generate keys, then configure [oauth2_proxy](https://github.com/oauth2-proxy/oauth2-proxy).

![](http://yuml.me/diagram/scruffy/class/[GSuite%20Employees%20{bg:wheat}]->[OAuth%20Proxy]->[Credentials;OAuth%20Endpoint{bg:green}]->[OAuth%20Proxy]->[Compute%20Engine;Nginx%20&%20Gollum])
