# HueCMS
Prerequisite: You will need to install Ruby on Rails in order to use the HueCMS.

## Quick Install:
Download and install like any typical Rails app

1. From the project directory, run `bundle install`
2. Then run `rake db: migrate`
3. Start the server: `rails server`

## What’s HUE CMS?

HUE CMS is a way for all users (even non-technical folk!) to easily manage all
of their online content in one place. It is platform agnostic and can be pushed
to multiple sources (including FTP, SFTP, Facebook, Twitter, and more to come.)

### Features include:
- Revision history
- Moderator/author workflows
-  Comments
- Syntax highlighting for HTML, Javascript, and CSS
- Email notifications

## Quick Guide:
1. Login with: admin@huecms.com
2. Password is: password
3. Create an endpoint
4. Create a layout, here's an example layout.
    `<html>
    <head>
      <title>Welcome</title>
    </head>
    <body>
      <content type="text">main</content>
    </body>
    </html>`
5. Create content
6. Add a layout to said content
7. Fill out content layout form
8. Add your endpoint
9. Save it
10. Publish
11. Your content is live!

