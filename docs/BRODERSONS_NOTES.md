# Brodersons structure (current state)

This section is the messiest part of the site. These notes are to keep it running until we rebuild it.

## What renders the winners page
- Page file: `brodersons-2025-winners.md` loops over categories and winners, and wires up the “jump to category” select and thumbnail hover script.
- Collections:
  - `_categories/` defines category titles, order, and section grouping.
  - `_winners/` holds one Markdown file per winner. Front matter keys in use: `submission_id`, `title`, `winning_level`, `category` (slug that matches a category file), `credited_winner`/`name`, optional `company_name`, `school_name`, `remote_videos` (array of URLs + optional duration), plus long-form body copy.
- Layout: `_layouts/winner.html` renders the detail page for each winner entry.
- Assets: `assets/winners/<category>/<submission>-<level>/`. Images are auto-ingested; `*-thumb.*` files become card thumbnails. PDFs and audio in the same folder attach to the detail page. Local video files are ignored (we expect remote video URLs in front matter).

## How assets get wired up
- `_plugins/winners_assets.rb` scans `_winners/` and `assets/winners/` at build time to populate `site.data.winner_assets`.
- The winners page and slideshow include read that generated data to find thumbnails, images, PDFs, and remote videos.
- If a winner file is missing a matching assets folder, the card still renders but without media.

## Quick tweaks that are safe
- Edit copy in `brodersons.md` or `brodersons-2025-winners.md` (no front matter changes needed).
- Update a winner’s name/title/description in its `_winners/*.md` file.
- Replace images/PDFs in an existing `assets/winners/...` folder, keeping the same folder name.

## Things to avoid until a rebuild
- Changing category slugs or folder names without a full audit — the template assumes slugs match across `_categories`, `_winners`, and `assets/winners`.
- Moving or renaming submission IDs; they tie together the Markdown files, assets folder names, and generated data.
- Adding new media types; only images, PDFs, audio, and remote video URLs are currently handled.

## Ideas for the future rebuild
- Replace the custom asset scanner with explicit data files (e.g., `_data/winners.yml`) to simplify onboarding.
- Generate the winners grid via data instead of hand-built markup in `brodersons-2025-winners.md`.
- Move “Brodersons art” and header blocks into includes so the page Markdown is mostly content fields.
