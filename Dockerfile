FROM golang:alpine
RUN mkdir /app 
ADD . /app/
WORKDIR /app 
RUN go build -o main .
RUN adduser -S -D -H -h /app tech
RUN apk add libcap && setcap 'cap_net_bind_service=+ep' /app/main
USER tech
EXPOSE 80
CMD ["./main"]


