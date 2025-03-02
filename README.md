# azdops-rm-docker

## Introduction

A cloud-native DevOps solution for [Redmine][redmine]/[RedMica][redmica] (RM Apps) with Azure Container Apps.

This repository contains RM App Container related files: Dockerfile, compose.yml, supported plugins, rmops sources, etc.

|Repository|Description|
|-|-|
|[azdops-rm]|Documents|
|[azdops-rm-base]|RM Base GitOps: Database, Container Registry, Backups, etc.|
|[azdops-rm-site]|RM Site GitOps: Azure Container Apps|
|[azdops-rm-docker]|RM App Container: Dockerfile, compose.yml, etc. (This repository)|

[redmine]: https://github.com/redmine/redmine
[redmica]: https://github.com/redmica/redmica
[azdops-rm]: https://github.com/yaegashi/azdops-rm
[azdops-rm-base]: https://github.com/yaegashi/azdops-rm-base
[azdops-rm-site]: https://github.com/yaegashi/azdops-rm-site
[azdops-rm-docker]: https://github.com/yaegashi/azdops-rm-docker

## Local development

[compose.yml](compose.yml) is provided
so that you can easily build and test Redmine container images.
Using a devcontainer is also recommended.

1. Place the Redmine source files in the `redmine` directory.
You can clone it from the official repository by either of the following commands:
    * Run `git clone https://github.com/redmine/redmine` for Redmine
    * Run `git clone https://github.com/redmica/redmica redmine` for RedMica
2. Copy file [`docker.env.example`](docker.env.example) to `docker.env`.
3. Copy file [`.env.example`](.env.example) to `.env` and set `COMPOSE_PROFILES` in it.
Choose one of the supported profiles: `sqlite`, `mysql`, `mariadb`, `postgres`.
4. Run `docker compose build` to build a container image.
5. Run `docker compose up -d` to start containers in the background.
    * The redmine container creates `./data/wwwroot` for `/home/site/wwwroot` volume.
    * The redmine container enters maintenance mode because the operation mode is not set.
    * The database container creates `./data/mysql` etc. for the database volume.
6. Perform the following initial setup steps in the container:
    1. Run `docker compose exec redmine-<profile> bash`.  This command invokes a shell in the redmine container.  The following commands should be run in this shell.
    2. Run `rmops dbinit` only when the profile is not `sqlite`.  It will prompt you for username/password of the DB admin user.
        * The username is `root` for `mysql` or `mariadb`, and `postgres` for `postgres`.
        * The password is `secret`.
    3. Run `rmops setup`.  This command does the initial migration tasks.  The admin password can be found in `/home/site/wwwroot/etc/password.txt`.
    4. Run `rmops env set mode rails`.  This command sets the operation mode of rails in service.
    5. Run `rmops sv restart`.  This command restarts all services in the container.
    6. Run `exit` to quit the shell in the redmine container.
8. Open http://localhost:8080 in your web browser to test the Redmine app.
