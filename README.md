# summary.ai — marketing site

Static marketing/landing site for summary.ai, built with [Hugo](https://gohugo.io)
(no theme — the few templates live in `layouts/`). One page: hero, a CSS mockup of
the desktop app, features, and a waitlist signup via an embedded Google Form.

This site is pure static output. The product itself lives in the sibling repos
(`ai-backend`, `auth-backend`, `auth-frontend`, `app`) — nothing here talks to them.

## Run it locally

```sh
make dev      # hugo server — live-reload dev server on :1313
make build    # hugo --gc --minify — production build into public/
make clean    # remove build output
```

Requires only the Hugo binary (`brew install hugo`).

## Wire up the real Google Form

The waitlist iframe URL is a **placeholder**. To activate it:

1. Create the form (name + email is plenty) at [forms.google.com](https://forms.google.com).
2. Send → `< >` (embed) → copy the iframe's `src` URL
   (`https://docs.google.com/forms/d/e/<long-id>/viewform?embedded=true`).
3. Paste it into `googleFormEmbedUrl` in `hugo.toml`.

Responses land in the form's linked Google Sheet.

## Deploy (GitHub Pages)

`.github/workflows/hugo.yml` builds and deploys on every push to `master`.
It is inert until:

1. This repo has a GitHub origin and the branch is pushed.
2. Pages is enabled on the repo: **Settings → Pages → Source: GitHub Actions**.

The workflow injects the correct `baseURL` for the Pages domain, so the
placeholder `baseURL` in `hugo.toml` never needs to change. For a custom domain
later, configure it under Settings → Pages and the workflow picks it up
automatically.

## Layout

```
hugo.toml             site config + params (form URL lives here)
content/_index.md     home page stub (copy lives in the template)
layouts/baseof.html   HTML shell, header/footer
layouts/home.html     the landing page: hero, app mockup, PTO band, features, waitlist
assets/css/main.css   all styles (minified + fingerprinted by Hugo pipes)
```
