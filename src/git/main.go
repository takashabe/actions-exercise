package main

import (
	"os"
	"path/filepath"

	"github.com/K0kubun/pp"
	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/config"
	"github.com/go-git/go-git/v5/plumbing/transport/http"
)

func main() {
	repo, err := git.PlainOpen(filepath.Clean("../../"))
	if err != nil {
		panic(err)
	}
	pp.Println(repo)

	h, err := repo.Head()
	if err != nil {
		panic(err)
	}
	_, err = repo.CreateTag("src/git/v0.0.2", h.Hash(), &git.CreateTagOptions{
		Message: "test",
	})
	if err != nil {
		panic(err)
	}

	err = repo.Push(&git.PushOptions{
		RemoteName: "origin",
		Progress:   os.Stdout,
		RefSpecs:   []config.RefSpec{config.RefSpec("refs/tags/*:refs/tags/*")},
		Auth: &http.BasicAuth{
			Username: "bump",
			Password: os.Getenv("GITHUB_TOKEN"),
		},
	})
	if err != nil {
		panic(err)
	}
}
