FROM node:19-alpine3.16

ENV APP_PATH /app/

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY package* $APP_PATH
RUN npm install
COPY . $APP_PATH

EXPOSE 5173

CMD ["npm", "run" ,"dev"]
