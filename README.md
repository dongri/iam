# create project
```
$ stack new web scotty-hello-world
```

# local dev
```
$ cd web
$ stack setup
$ stack build
$ PORT=3001 stack exec web
```

# heroku
```
$ cd iam

$ heroku login
$ heroku container:login

$ heroku crate 
or
$ git remote add heroku https://git.heroku.com/dongri.git

# deploy
$ heroku container:push web

$ heroku container:release web

$ heroku logs --tail
```
