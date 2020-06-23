FROM node:10

# Install Truffle
RUN npm install -g truffle
RUN npm config set bin-links false

# Move Contract Files
COPY contracts ./contracts
COPY migrations ./migrations
COPY test ./test
COPY truffle-config.js ./truffle-config.js

# Move Vue Files
COPY vapp/src ./vapp/src
COPY vapp/public ./vapp/public
COPY vapp/package.json ./vapp/package.json
COPY vapp/package-lock.json ./vapp/package-lock.json

# Clean Install NPM Dependencies
RUN cd vapp && npm install




