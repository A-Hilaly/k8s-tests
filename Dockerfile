FROM alpine:3.7

EXPOSE 8080
COPY server .

ENTRYPOINT ["./server"]

