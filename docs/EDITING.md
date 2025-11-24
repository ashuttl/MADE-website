# MADE website editing guide

This repo is a Jekyll site. You mostly work in Markdown with a little YAML front matter. The goal is that designers can edit text, swap images, and add events without touching Ruby or JavaScript.

## Run the site locally (optional but recommended)
- Install Ruby 2.5+ and bundler.
- In the repo: `bundle install` then `bundle exec jekyll serve`.
- Visit `http://localhost:4000`. The site rebuilds when you save files.

## Where things live
- **Pages:** root `.md` files like `about.md`, `membership.md`, `brodersons.md`. They use the `page` layout.
- **Home page:** `index.md` calls includes (`hero.html`, `upcoming-events.html`, `instagram-feed.html`). CTA buttons come from `_data/home_ctas.yml`.
- **Events:** `_events/` collection. Each file is one event card.
- **Broderson winners:** `_winners/` plus assets in `assets/winners/` (see `docs/BRODERSONS_NOTES.md` before changing).
- **Categories:** `_categories/` drive winner grouping/order.
- **Shared includes:** `_includes/` (hero, event cards, banners, Instagram embed, etc.).
- **Global data:** `_data/banner.yml` (site-wide alert), `_data/footer.yml` (contact/footer text), `_data/home_ctas.yml` (home hero buttons).
- **Header navigation:** `_data/nav.yml` controls the top nav links and their active-state rules.
- **Styles:** `_sass/` (design tokens in `_variables.scss`, `_colors.scss`; semantic styles in `_sass/semantic/`), compiled to `assets/css/main.css`.
- **Images/files:** `assets/images/` (general) and `assets/winners/` (Broderson media).

## Common edits
- **Update static page copy:** open the page `.md` file, edit Markdown below the front matter, save. Keep the existing front matter keys.
- **Toggle/replace the global banner:** `_data/banner.yml` → `enabled`, `text`, `url`, `theme`, `exclude_paths`.
- **Home hero CTAs:** `_data/home_ctas.yml` controls the button text/links under the hero. `index.md` holds the headline/image URL.
- **Footer contact links/text:** `_data/footer.yml`.
- **Add or edit events:** duplicate an existing file in `_events/` and adjust front matter:
  - `title`, `date` (YYYY-MM-DD), optional `start_time`/`end_time`
  - `location` + `address`
  - `image` (path in `assets/images/events/`)
  - `price`, `ticket_link`, `detail_url`, `button_label`
  - Body text renders as the description. Events drop off the home carousel the day after they occur.
- **Embed Instagram grid:** `_includes/instagram-feed.html` holds the Behold embed; swap the feed ID or link text there if needed.
- **Adjust navigation:** header links live in `_layouts/default.html`.

## Adding assets
- Put general images in `assets/images/...` and reference with a leading `/assets/...` path in Markdown/front matter.
- For Broderson assets, follow the directory pattern in `assets/winners/` (details in `docs/BRODERSONS_NOTES.md`).

## Build/deploy notes
- Netlify/Cloudflare-style static build; local command is `bundle exec jekyll build`.
- Helper scripts: `build.sh` (local) and `cf_production_build.sh` (Cloudflare Pages). You usually won’t need to touch these for content edits.

## If something looks scary
- Most complexity is around Broderson winners and their assets. See the notes file before editing, and plan a rebuild later if time allows.
