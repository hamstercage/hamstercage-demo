# Hamstercage Demo

This project provides a sample [Hamstercage](https://hamstercage.io/) repository for testing and exploration.

The repo consists of a Hamstercage repo for a fictional host `webserver`, and defines two tags. [docker/](docker/) contains a docker image definition for a testing image that allows you to run an nginx web server and work with Hamstercage and this repo interactively.


## Demo

### Check out this repository on a host with Docker installed and running

```shell
git checkout git@github.com:hamstercage/hamstercage-demo.git
cd hamstercage-demo
```

### Build the demo Docker image

This image is based on nginx, and has Hamstercage installed.

```shell
docker build -t hamstercage-demo docker
```

### Run the demo Docker image

When you run the image, it will start an nginx web server, and put you into a shell so you can work with Hamstercage interactively. (nginx will write the access log to the console, this might be confusing, but is harmless.)

```shell
docker run -it --rm -h webserver -v $PWD:/hamstercage-demo -p 8080:8080 hamstercage-demo
```

### Try out Hamstercage in the Docker container
The current directory will be mounted as `/hamstercage-demo`, making the demo Hamstercage repo available inside the container

1. Open http://localhost:8080 in a browser an observe the default nginx index page.
2. Inspect the contents of `/etc/motd` and observe that it has the default Debian contents.
3. Run `hamstercage ls -l`. The output will list two files with their metadata. The first column in the output is `*`, indicating that the installed files and the files in the repo differ:
    ```
    root@webserver:/hamstercage-demo# hamstercage ls -l
    * -rw-r--r-- root root 286 19.03. all /etc/motd
    * -rw-r--r-- root root 615 25.01. web /usr/share/nginx/html/index.html
    ```
4. Run `hamstercage diff`. You will be presented with a unified diff for both files, showing the differences between the installed version and the one in the repo:
    ```
    root@webserver:/hamstercage-demo# hamstercage diff
    --- tags/web/usr/share/nginx/html/index.html	2022-06-05T17:16:49.823665
    +++ /usr/share/nginx/html/index.html	2022-01-25T15:03:52
    @@ -1,7 +1,7 @@
    <!DOCTYPE html>
    <html>
    <head>
    -<title>Welcome to the Hamstercage Demo!</title>
    +<title>Welcome to nginx!</title>
    <style>
    html { color-scheme: light dark; }
    body { width: 35em; margin: 0 auto;
    @@ -9,8 +9,14 @@
    </style>
    </head>
    <body>
    -<h1>Welcome to the Hamstercage Demo!</h1>
    -<p>If you see this page, the Hamstercage has applied the repo to the running container successfully!</p>
    +<h1>Welcome to nginx!</h1>
    +<p>If you see this page, the nginx web server is successfully installed and
    +working. Further configuration is required.</p>
    +
    +<p>For online documentation and support please refer to
    +<a href="http://nginx.org/">nginx.org</a>.<br/>
    +Commercial support is available at
    +<a href="http://nginx.com/">nginx.com</a>.</p>
    
    <p><em>Thank you for using nginx.</em></p>
    </body>
    --- tags/all/etc/motd	2022-06-05T17:17:36.903811
    +++ /etc/motd	2022-03-19T13:46:00
    @@ -1,4 +1,7 @@
    
    -This is the Hamstercage Demo
    +The programs included with the Debian GNU/Linux system are free software;
    +the exact distribution terms for each program are described in the
    +individual files in /usr/share/doc/*/copyright.
    
    -This file has been updated by Hamstercage.
    +Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
    +permitted by applicable law.
    ```

    Note how the installed version is considered the “new” one (indicated with `+` in the diff), whereas the one in the repo the “old” one (`-`).

5. Run `hamstercage apply` to apply the version in the repo to the installed files. No output should be produced.
6. Run `hamstercage ls -l` again. Note that the `*` in the first column is gone. You can reload the page in the browser, and look at `/etc/motd` to see the updated contents.
    ```
    root@webserver:/hamstercage-demo# hamstercage ls -l
    -rw-r--r-- root root  74 17:17 all /etc/motd
    -rw-r--r-- root root 439 17:16 web /usr/share/nginx/html/index.html
    ```
7. Run `hamstercage diff` again and observe that there is no output, indicating that the installed files and the ones in the repo are identical.
8. Make a change to `/usr/share/nginx/html/index.html` inside the container, then run `hamstercage diff` to observe the change.
9. Run `hamstercage save` to save the changes from the installed files to repository. Look at the repo on your machine, for example by opening [`tags/web/usr/share/nginx/html/index.html`](tags/web/usr/share/nginx/html/index.html) in an editor, or running `git status`, and see that the change from inside the container has been saved to the repo.

Congratulations, that's a full round trip of the Hamstercage functionality. Feel free to experiment and explore with this test repo, or start using Hamstercage on one of your own machines!