#### Docker image to set up a RServer with ROpenSci + extra packages

The extra packages are for ML and survival analysis

Build with: -

```
docker build -t ck/ropensci .
```

Run with: -

```
docker run -d -v $HOME:/home/rstudio/home -e ROOT=true -p 8787:8787 ck/ropensci
```

The default password is rstudio / rstudio.
