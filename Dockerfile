FROM nginx:alphine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY buils/ .
EXPOSE 80
CMD["nginx","-g","daemon off;"]
