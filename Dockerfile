FROM ghcr.io/dodona-edu/dolos-api:latest

# Set Rails environment to production
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Heroku will set PORT dynamically, Dolos API listens on process.env.PORT
ENV PORT=${PORT:-3000}
EXPOSE $PORT

# The dolos-api image already has the correct CMD to start the web server