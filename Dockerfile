FROM node:12-slim
# Environment variables
ENV SERVER_PORT 8080
ENV DB_HOST 'localhost'
ENV DB_PORT 27017
ENV DB_NAME 'nodeapp'
ENV DB_USERNAME 'dan'
ENV DB_PASSWORD  'dan'

# adduser to run app
RUN addgroup -gid 1020 appuser && \
        adduser --gid 1020  --system --disabled-login --home /app --shell /sbin/nologin -u 1020 appuser

# deploy app into docker image	
WORKDIR /app

# Install app dependencies
COPY package*.json ./

RUN npm ci --only=production

# Bundle app source
COPY . .

RUN chown appuser:appuser -R /app
EXPOSE $SERVER_PORT
USER appuser
CMD ["node", "app.js"]