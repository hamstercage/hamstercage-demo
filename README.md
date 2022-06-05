# Hamstercage Demo

This project provides a sample Hamstercage repository for testing and exploration.


# Demo

```shell
docker build -t hamstercage-demo docker
docker run -it --rm -h webserver -v $PWD:/hamstercage --entrypoint=/bin/bash hamstercage-demo
```
