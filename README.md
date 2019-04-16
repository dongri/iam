
```
$ stack new web scotty-hello-world
```

```
$ cd web
$ stack setup
$ stack build
$ stack exec web

```

```
$ docker build -t gcr.io/i-am-d/web -f Dockerfile.build .
$ gcloud docker -- push gcr.io/i-am-d/web
```
