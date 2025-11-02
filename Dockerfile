# Dockerfile
FROM ghcr.io/dodona-edu/dolos:latest

# Heroku expects the app to listen on $PORT
ENV PORT=3000

# Expose the port
EXPOSE 3000

# Start Dolos (it will automatically use PORT from env)
CMD ["npm", "start"]