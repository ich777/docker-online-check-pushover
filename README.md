# Basic Ping online check with Pushover notification in Docker optimized for Unraid

This is a simple container that will check if a domain name or IP address is pingable and send you a message with Pushover if it goes offline.

You can install it on your machine to get notified with Pushover if a site goes down, or you can install it on a remote machine to ping your server and get a notification if it's not reachable.



## Env params
| Name | Value | Example |
| --- | --- | --- |
| HOST | IP or Domainname to ping | google.com |
| PING_INTERVAL| Interval in wich the Host is pinged (in seconds) | 300 |
| PING_TIMEOUT | Time that the Host has to answer the ping request (in seconds) | 10 |
| PING_RETRY | Time to wait to retry it after the ping fails (in seconds) | 3600 |
| PUSHOVER_APP_TOKEN | Pushover APP Token | "YOURSECRETAPPTOKEN" |
| PUSHOVER_USER_TOKEN | Pushover User Token | "YOURSECRETUSERTOKEN" |
| PUSHOVER_TITLE | Customized Pushover Message Title | Online Check |
| PUSHOVER_MESSAGE | Customized Pushover Message | google.com is offline! |
| PUSHOVER_PRIORITY | Customize the Pushover Priority ('-2': Lowest priority | '-1': Low Priority | '0': Normal Priority | '1': High Priority | '2': Emergency Priority) | 0 |

>**NOTE** This Docker must be started with the follwoing parameter: "--restart=unless-stopped" otherwise it will not retry after a failed ping request and you must restart the container manually.

## Run example
```
docker run --name OnlineCheckYourServer -d \
    --env 'HOST=google.com' \
    --env 'PING_INTERVAL=300' \
    --env 'PING_TIMEOUT=10' \
    --env 'PING_RETRY=3600' \
    --env 'PUSHOVER_APP_TOKEN=YOURSECRETAPPTOKEN' \
    --env 'PUSHOVER_USER_TOKEN=YOURSECRETUSERTOKEN' \
    --env 'PUSHOVER_TITLE=Online Check' \
    --env 'PUSHOVER_MESSAGE=google.com is offline!' \
    --env 'PUSHOVER_PRIORITY=0' \
    --restart=unless-stopped \
    ich777/online-check-pushover
```


#### Support Thread: https://forums.unraid.net/topic/83786-support-ich777-application-dockers/