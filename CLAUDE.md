# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

The **public marketing site** for summary.ai — a single-page Hugo static site (the
landing + waitlist page) served at **summary-agent.io** (`static/CNAME`). There is
**no external theme**: all templates live directly in `layouts/`, and the page copy
lives in those templates rather than in markdown.

## Commands

Local commands live in the `Makefile`:

- `make dev` — `hugo server` with live reload on `:1313`
- `make build` — `hugo --gc --minify` → `public/`
- `make clean` — remove `public/` and `resources/_gen/`

From the root `Makefile`: `make marketing-site` runs this site's `make dev`, and
`make up` launches it in the tmux session.

## Architecture

- `hugo.toml` — site config (TOML): `baseURL`, `title`, `disableKinds =
  ['taxonomy', 'term']` (single page, no archive/tag pages), and `params`
  (`tagline`, `description`, and `googleFormEmbedUrl` — a **placeholder** that must be
  replaced with the real waitlist Google Form embed URL).
- `content/_index.md` — minimal front-matter stub only. The actual landing content
  (hero, app mockup, feature grid, waitlist form) lives in `layouts/home.html`;
  `layouts/baseof.html` is the HTML shell (header/footer).
- `assets/css/main.css` — all styles, fingerprinted + minified via Hugo Pipes.
- `i18n/`, `data/`, and `themes/` are present but empty — the site is single-language
  and themeless. `archetypes/default.md` exists but is unused (single-page site).
- **Deploy:** `.github/workflows/hugo.yml` builds with Hugo 0.163.1 and deploys to
  GitHub Pages on push to `master`; the Pages base URL is re-injected at deploy time
  and the custom domain comes from `static/CNAME`.

## Git workflow

- **Branch per task.** Never commit new work directly to `master`. Before starting,
  create a branch off `master` named `type/short-description` (Conventional-Commit-
  style prefix), e.g. `feat/pricing-section`, `fix/hero-copy`, `chore/bump-hugo`.
- **Commit after every add or fix.** Once a discrete change is added or a bug is fixed
  and the site builds clean (`make build`), commit it — don't batch unrelated changes
  into one commit.
- **Conventional Commits** for messages: `type(scope): summary`, e.g.
  `feat(home): add testimonials`, `fix(css): hero spacing`. Common types: `feat`,
  `fix`, `chore`, `refactor`, `docs`.
- **Push after committing.** Push the branch to the remote after each commit (use
  `git push -u origin <branch>` on the first push) so work is backed up and reviewable.
- **Merging to `master` publishes the live site.** The GitHub Pages workflow deploys
  on every push to `master`, so land changes on a branch/PR and only merge when you're
  ready for them to go live.

## Conventions

- Config is TOML (`hugo.toml`). Page copy is edited in `layouts/home.html`, not in
  markdown.
- Single-page site: no taxonomies, no i18n, no theme; the archetype is unused.
- Deploy is automatic on `master` via GitHub Actions (`.github/workflows/hugo.yml`).
