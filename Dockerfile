# Use a supported Debian version (Bullseye = Debian 11)
FROM python:3.10-slim

# Update package index and upgrade packages
RUN apt update && apt upgrade -y

# Install git (needed for some Python packages that install from Git URLs)
RUN apt install git -y

# Copy only requirements first (better layer caching)
COPY requirements.txt /requirements.txt

# Upgrade pip and install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r /requirements.txt

# Create app directory
RUN mkdir -p /VJ-File-Store
WORKDIR /VJ-File-Store

# Copy the rest of the application
COPY . /VJ-File-Store

# Run the bot
CMD ["python", "bot.py"]
