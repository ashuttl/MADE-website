# Maine Ad + Design Website

This is the website for Maine Ad + Design, (maybe) the oldest advertising club in the United States, supporting the creative community in Maine since 1923.

## How this site works

- This site is built with Jekyll, a static site generator.
- The code and content is hosted here, on GitHub.
- The site itself is hosted on Cloudflare.
- When there are new commits to the main branch of this repo on GitHub, CloudFlare automatically fetches the updates, rebuilds the site, and starts serving the new version. (It can take a few minutes before you see the new version live online.)
- The 2025 Brodersons winners content is here too. This is the biggest and most complicated part of the site, and it will probably need to be rebuilt before the next Brodersons.

## How to make changes to this website

1. Create a GitHub account, if you don't have one already.
2. Get someone to add you to this organization and give you permissions to edit this repo.
3. Make changes to the files you want to change, and commit them. See `docs/EDITING.md` for common tasks (home page, events, banner, footer).
4. You can make and commit those changes right through the GitHub web interface. But if you're doing this more than once, I strongly recommend you set yourself up to build the site locally so you can test your changes before pushing them. Here's how, assuming you're on a Mac:
   1. Clone this repository to your computer. Lots of ways to do this, but if you're new to Git and GitHub, the [GitHub Desktop client](https://desktop.github.com/download/) can be a huge help.
   2. [Install Homebrew](https://brew.sh) if you don't already have it.
   3. Use Homebrew to install this site's dependencies. Run this in your Terminal: `brew install ruby node`
   4. Run `bundle install` to install dependencies
   5. Run `bundle exec jekyll serve` to start the development server whenever you want to make and test changes.
   6. Leave that Terminal window open, and visit `http://localhost:4000` to see the website served from your own computer. Make changes to the files, and the site will automatically refresh in your browser.
   7. Happy with your changes? Commit them and push back to GitHub.

## Troubleshooting

Even if you follow these steps, you might occasionally find that your pushed changes aren't reflected on the live site. If this happens, there's probably a problem with Cloudflare's build process. If that's the case, you'll need to check the build logs at dash.cloudflare.com to see what went wrong. If you're not sure how to do that, or if you need help or access, get in touch with Andrew Shuttleworth.

## Structure

- `_layouts/`: HTML templates
- `_includes/`: Reusable HTML components
- `_sass/`: SCSS styles organized by design and semantic concerns
- `assets/`: Static assets (CSS, JS, images)
- `_brodersons/`: Collection of Broderson Award entries
- `pattern-library/`: A visual reference of all styled elements
