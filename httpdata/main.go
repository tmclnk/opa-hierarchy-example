package main

import (
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", getRoot)
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}
	fmt.Println("Listening on port", port)
	err := http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
	if err != nil {
		log.Fatalln(err.Error())
	}
}

func getRoot(w http.ResponseWriter, r *http.Request) {
	sid := r.URL.Path[1:]
	sessions, err := getSessions("./data.json")
	if err != nil {
		w.Write([]byte(err.Error()))
		w.WriteHeader(500)
		return
	}
	principal := sessions[sid]

	if principal == nil {
		w.WriteHeader(404)
	}

	bytes, err := json.Marshal(principal)
	if err != nil {
		w.Write([]byte(err.Error()))
		w.WriteHeader(500)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	json := string(bytes)
	fmt.Println(json)
	io.WriteString(w, json)
}

func getSessions(filename string) (map[string]*Principal, error) {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	var sessions map[string]*Principal
	err = json.Unmarshal(data, &sessions)
	if err != nil {
		return nil, err
	}
	return sessions, nil
}

type Principal struct {
	Username      string `json:"username"`
	CurrentBranch string `json:"current_branch"`
}
