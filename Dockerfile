# Base image
FROM node:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
  libnss3-dev \
  libglib2.0-0 \
  libxi6 \
  libxtst6 \
  libxss1 \
  libgtk-3-0 \
  libgbm1

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Install global packages
RUN npm install -g playwright axios puppeteer puppeteer-extra puppeteer-extra-plugin-stealth chalk dotenv node-cron tiktok-video-downloader

# Copy app files
COPY . .

# Expose the port
EXPOSE 3000

# Run npm i and the uploadVideo.js script
CMD ["bash", "-c", "npm i && node tests/uploadVideo.js"]
