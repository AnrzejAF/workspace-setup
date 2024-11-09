Find the username for your GUID and UID, default have 1000, so run this command in your host terminal:

```sh
docker run --rm swift:latest bash -c 'cut -d: -f1,3,4 /etc/passwd'
```

change **swift:latest** for your image name.