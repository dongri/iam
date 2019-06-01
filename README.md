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
$ heroku login
$ heroku container:login

$ heroku crate 
or
$ git remote add heroku https://git.heroku.com/dongri.git

$ heroku container:push web --app dongri

$ heroku container:release web

$ heroku logs --tail
```

