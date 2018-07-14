# cheatsheet-docker-A4
Docker CheatSheets In A4

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a> [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/cheatsheet-docker-A4/issues) or star [the repo](https://github.com/DennyZhang/cheatsheet-docker-A4).

Printable version on A4 page: [cheatsheet-docker-A4.pdf](cheatsheet-docker-A4.pdf)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

See more CheatSheets from Denny: [here](https://github.com/topics/denny-cheatsheets)

Table of Contents
=================
   * [Docker Compose](#docker-compose)
   * [Check Containers](#check-containers)
   * [Container Basic](#container-basic)
   * [Docker Machine](#docker-machine)
   * [Scripts](#scripts)
   * [License](#license)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

# Docker Compose

| Name                                | Summary                                                                                            |
| :---------------------------------- | -------------------------------------------------------------------------------------------------- |
| Change entrypoint to run nothing    | `entrypoint: ["tail", "-f", "/dev/null"]`                                                          |
| Change restart policy               | `restart: always` [link](https://docs.docker.com/compose/compose-file/compose-file-v2/#restart)  |
| Mount file                          |                                                                                                    |
| Start compose env                   | `docker-compose up` `docker-compose up -d`                                                         |
| Stop compose env                    | `docker-compose down` `docker-compose down -v`                                                     |
| Check logs                          | `docker-compose logs`                                                                              |

# Check Containers

| Name                                | Summary                                                       |
| :---------------------------------- | -----------------------------------------------               |
| Tail container logs                 | `docker logs --tail 5 $container_name`                        |
| Check container healthcheck status  | `docker inspect --format '{{.State.Health}}' $container_name` |

# Container Basic

| Name                                    | Summary                                             |
| :----------------------------------     | -----------------------------------------------     |
| Create docker image                     | `docker build -t imgname .`                         |
| Start docker container                  | `docker run -p 4000:80 imgname`                     |
| Start docker container in detached mode | `docker run -d -p 4000:80 imgname`                  |
| Enter a running container               | `docker exec -it [container-id] sh`                 |
| List containers                         | `docker ps`                                         |
| List all containers                     | `docker ps -a`                                      |
| List containers by labels               | `docker ps --filter "label=org.label-schema.group"` |
| Stop container                          | `docker stop <hash>`                                |
| Remove container                        | `docker rm <hash>`                                  |
| Remove all containers                   | `docker rm $(docker ps -a -q)`                      |
| Force shutdown of one given container   | `docker kill <hash>`                                |
| List all images                         | `docker images -a`                                  |
| Login to docker hub                     | `docker login`                                      |
| Tag <image>                             | `docker tag <image> username/repo:tag`              |
| Docker push a tagged image to repo      | `docker push username/repo:tag`                     |
| Run image from a given tag              | `docker run username/repo:tag`                      |
| Remove the specified image              | `docker rmi <imagename>`                            |
| Remove all docker images                | `docker rmi $(docker images -q)`                    |

# Docker Machine

| Name                    | Summary                                             |
| :---------------------- | --------------------------------------------------- |
| Get node env            | `docker-machine env vm1`                            |
| Copy files              | `docker-machine scp docker-compose.yml vm1:/tmp/`   |
| ssh to vm               | `docker-machine ssh vm1`                            |
| Inspect a node          | `docker-machine ssh vm1 "docker node inspect <ID>"` |
| List the nodes          | `docker-machine ssh vm1 "docker node ls"`           |
| Start a VM              | `docker-machine start vm1`                          |
| Stop all running VMs    | `docker-machine stop $(docker-machine ls -q)`       |
| Delete all VMs          | `docker-machine rm $(docker-machine ls -q)`         |

# Scripts
- Clean up Disk

Remove All Useless Resources.

```
docker ps --filter status=exited -aq \
 | xargs -r docker rm -v
```

Remove unused docker images
```
docker rmi $(docker images | grep "<none>"\
 | awk -F' ' '{print $3}')
```

Remove orphaned docker volumes
```
docker volume rm \
 $(docker volume ls -qf dangling=true)
```

Remove dead containers
```
docker ps --filter status=dead -aq \
 | xargs -r docker rm -v
```

Remove intermediate containers generated during docker build
```
docker ps -a | grep "/bin/sh -c" | \
  awk -F' ' '{print $1}' | xargs docker rm
```

Remove Image with <none> string
```
echo "Remove docker images with <none> string"
if docker images | grep none | tee; then
   docker rmi $(docker images | grep "<none>"  | awk -F' ' '{print $3}') | tee
fi
```

<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

<a href="https://www.dennyzhang.com"><img align="right" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
