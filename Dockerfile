FROM ghcr.io/dodona-edu/dolos:latest

# Create dir for wrapper
USER root
RUN mkdir -p /app/bin && chown -R node:node /app
COPY bin/start-dolos.sh /app/bin/start-dolos.sh
RUN chmod +x /app/bin/start-dolos.sh

# Ensure we run as the node user if the base image expects that
USER node

# Make sure Heroku's $PORT is honored by the app (Dolos listens on process.env.PORT)
ENV PORT=${PORT:-3000}
EXPOSE 3000

# Use the wrapper as the process that Heroku runs; wrapper forwards signals and exits properly
CMD ["/app/bin/start-dolos.sh"]