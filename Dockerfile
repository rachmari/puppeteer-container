FROM ianwalter/pnpm:v1.3.0

LABEL "com.github.actions.name"="Puppeteer Container"
LABEL "com.github.actions.description"="A GitHub Action / Docker image for Puppeteer, the Headless Chrome Node API"
LABEL "com.github.actions.icon"="globe"
LABEL "com.github.actions.color"="green"

LABEL "repository"="http://github.com/ianwalter/puppeteer-container"
LABEL "homepage"="http://github.com/ianwalter/puppeteer-container"
LABEL "maintainer"="Ian Walter <pub@ianwalter.dev>"

RUN  apt-get update \
     # See https://crbug.com/795759
     && apt-get install -yq libgconf-2-4 \
     # Install latest chrome dev package, which installs the necessary libs to
     # make the bundled version of Chromium that Puppeteer installs work.
     && apt-get install -y wget --no-install-recommends \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && apt-get update \
     && wget --no-verbose -O /tmp/chrome.deb http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_88.0.4324.182-1_amd64.deb \
     && apt install -y /tmp/chrome.deb \
     && rm /tmp/chrome.deb \
     && rm -rf /var/lib/apt/lists/*

# When installing Puppeteer through npm, instruct it to not download Chromium.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/google-chrome-stable
