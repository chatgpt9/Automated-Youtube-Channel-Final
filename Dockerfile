# Use the official Node.js image as the base image
FROM node:latest

# Set the working directory
WORKDIR /app

# Install Xvfb and other required packages
RUN apt-get update && \
    apt-get install -y \
    xvfb \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxcomposite1 \
    libxrandr2 \
    libgtk-3-0 \
    libgbm1 \
    libxss1

# Install global dependencies
RUN npm install -g \
    playwright \
    axios \
    puppeteer \
    puppeteer-extra \
    puppeteer-extra-plugin-stealth \
    chalk \
    dotenv \
    node-cron \
    tiktok-video-downloader

# Copy package.json and package-lock.json into the working directory
COPY package.json package-lock.json ./

# Install local dependencies
RUN npm install

# Copy the rest of the application code into the working directory
COPY . .

# Set the entrypoint script to execute the tests/uploadVideo.js script with Xvfb
ENTRYPOINT ["xvfb-run", "--server-args='-screen 0 1024x768x24'", "node", "tests/uploadVideo.js"]
