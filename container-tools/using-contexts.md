# Using docker context to deploy to remote server

- Ensure you have ssh keys to remote log in without password prompt
- Set context:

    ```docker context create docker.cklein.us --docker "host=ssh://docker@docker.cklein.us"```
- One time use of context

    ```docker-compose --context docker.cklein.us up -d ```
- Consistent use of context

    ```docker context use docker.cklein.us```