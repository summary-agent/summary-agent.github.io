.PHONY: dev build clean

# --- Marketing site ---------------------------------------------------------
# Hugo live-reload dev server on :1313. Needs only the hugo binary
# (`brew install hugo`).
dev:
	hugo server

# Production build into public/ (what the Pages workflow deploys).
build:
	hugo --gc --minify

clean:
	rm -rf public resources/_gen
