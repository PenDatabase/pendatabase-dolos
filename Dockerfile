FROM ghcr.io/dodona-edu/dolos:latest

# Heroku will set PORT dynamically, but default to 3000 for local testing
ENV PORT=${PORT:-3000}
EXPOSE $PORT

# Use the base image's default command (already configured to start Dolos)