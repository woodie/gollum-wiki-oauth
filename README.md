# Gollum Wiki OAuth

We want to give our employees — all GSuite users but not Github users — access to a GitHub style wiki.
Within Gollum, all commits can be from the sinlge user, but we intend to set the git name and email per commit (from OAuth). 

We'd like to eventually have an automated setup were possible and maybe even create a 
[stateless container image](https://github.com/gollum/gollum/issues/1767)
Installing `Nginx`, `Let's Encrypt ` and `Gollum` are straight forward,
but setting up the OAuth proxy is a bit tricky.

## The files

This repo contains the files for Gollum Wiki:

- Configuration for Gollum:<br>
  /etc/gollum/config.rb

- Nginx configuration for Gollum:<br>
  /etc/nginx/conf.d/gollum.conf

- Systemd service file for Gollum:<br>
  /etc/systemd/system/gollum.service

- Nginx general configuration:<br>
  /etc/nginx/nginx.conf

