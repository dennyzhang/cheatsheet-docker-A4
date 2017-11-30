# cheatsheet-docker-A4
Docker CheatSheets In A4

<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com) [![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Slack](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/slack.png)](https://www.dennyzhang.com/slack) [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/cheatsheet-docker-A4/issues) or star [the repo](https://github.com/DennyZhang/cheatsheet-docker-A4).

Printable version on A4 page: [cheatsheet-docker-A4.pdf](cheatsheet-docker-A4.pdf)

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

See more CheatSheets from Denny: [here](https://github.com/topics/denny-cheatsheets)

- Container

| Name                                        | Summary                                 |
| :------------------------------------------ | --------------------------------------- |
| `docker build -t imgname .`                 | Create docker image                     |
| `docker run -p 4000:80 imgname`             | Start docker container                  |
| `docker run -d -p 4000:80 imgname`          | Start docker container in detached mode |
| `docker exec -it [container-id] sh`         | Enter a running container               |
| `docker ps`                                 | List containers                         |
| `docker ps -a`                              | List all containers                     |
| `docker stop <hash>`                        | Stop container                          |
| `docker rm <hash>`                          | Remove container                        |
| `docker rm $(docker ps -a -q)`              | Remove all containers                   |
| `docker kill <hash>`                        | Force shutdown of one given container   |
| `docker images -a`                          | List all images                         |
| `docker login`                              | Login to docker hub                     |
| `docker tag <image> username/repo:tag`      | Tag <image>                             |
| `docker push username/repo:tag`             | Docker push a tagged image to repo      |
| `docker run username/repo:tag`              | Run image from a given tag              |
| `docker rmi <imagename>`                    | Remove the specified image              |
| `docker rmi $(docker images -q)`            | Remove all docker images                |

- Compose

| Name                     | Summary                               |
| :----------------------- | ----------------------------------    |
| `docker-compose up`      | Start a compose env from yaml file    |
| `docker-compose up -d`   | Start a compose env in detached mode  |
| `docker-compose logs`    | Check logs                            |
| `docker-compose down`    | Stop current compose env              |
| `docker-compose down -v` | Stop compose env, and destroy volumes |

- Docker Machine

| Name                                                | Summary              |
| :-------------------------------------------------  | -------------------  |
| `docker-machine env vm1`                            | Get node env         |
| `docker-machine scp docker-compose.yml vm1:~`       | Copy files           |
| `docker-machine ssh vm1`                            | ssh to vm            |
| `docker-machine ssh vm1 "docker node inspect <ID>"` | Inspect a node       |
| `docker-machine ssh vm1 "docker node ls"`           | List the nodes       |
| `docker-machine start vm1`                          | Start a VM           |
| `docker-machine stop $(docker-machine ls -q)`       | Stop all running VMs |
| `docker-machine rm $(docker-machine ls -q)`         | Delete all VMs       |

- Clean up Disk

```
# Remove All Useless Resources.

docker ps --filter status=exited -aq \
 | xargs -r docker rm -v

# Remove unused docker images
docker rmi $(docker images | grep "<none>"\
 | awk -F' ' '{print $3}')

# Remove orphaned docker volumes
docker volume rm \
 $(docker volume ls -qf dangling=true)

# Remove dead containers
docker ps --filter status=dead -aq \
 | xargs -r docker rm -v

# Remove intermediate containers generated during docker build
#+BEGIN_SRC sh
docker ps -a | grep "/bin/sh -c" | \
  awk -F' ' '{print $1}' | xargs docker rm

# Remove Image with <none> string
echo "Remove docker images with <none> string"
if docker images | grep none | tee; then
   docker rmi $(docker images | grep "<none>"  | awk -F' ' '{print $3}') | tee
fi
```

<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
