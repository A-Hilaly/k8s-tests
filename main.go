package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("requested at %s\n", r.URL.Path[1:])
		fmt.Fprintf(w, "200. Path : %v", r.URL.Path[1:])
	})
	log.Printf("Listening on port 8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
