# Pre-baked image for the fix-the-n-plus-one scenario.
#
# Building this once and pushing to GHCR cuts codespace first-boot from
# ~2-3 minutes (image pull + bundle install) down to ~15 seconds (image
# pull, gems already inside).
#
# Build + push from the repo root:
#   bin/build-scenario-image fix-the-n-plus-one
FROM mcr.microsoft.com/devcontainers/ruby:1-3.3

# Install gems system-wide so `bundle install` inside the codespace is
# a no-op (all dependencies already resolved + cached).
WORKDIR /usr/src/preinstall
COPY Gemfile Gemfile.lock ./
RUN bundle config set --global silence_root_warning true \
 && bundle install \
 && rm -rf /usr/src/preinstall

WORKDIR /workspaces
