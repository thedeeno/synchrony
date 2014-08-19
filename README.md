# Synchrony

A proof-of-concept for visualizing manufacturing systems in realtime.

After an admin sets up the production floor, managers can open the `/monitor` app and watch employees perform tasks.

In this simple demo, employees are tasked with organizing containers distributed across the production floor into ordered lines. The integration test suite hits a backened api while the manager watches his graph. You can imagine the employees using mobile devices which trigger events on the server that ultimatley are visualized for the manager on his/her graph.

## See it in action

**Play:** [synchrony.webm](https://raw.githubusercontent.com/thedeeno/synchrony/master/synchrony.webm)

## Run it yourself

Requires:

* ruby >= 2.1.0
* node >= 0.10.28

```bash
# clone the repository
git clone https://github.com/thedeeno/synchrony.git

# install node packages
npm install -g bower grunt-cli

# install gems and bowers components   
bundle && bower install

# start the server
bundle exec foreman start

# watch the integration tests
bundle exec cucumber
```

## Details

This sinatra app combines 2 micro applications (`/api` and `/monitor`) with a faye messaging application (mounted at `/faye`). The **monitor** subscribes to events published by the **api**. 

The cucumber integration in `features` is the primary way to see this app in action. 

