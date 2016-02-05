# Synchrony

A proof-of-concept for visualizing manufacturing systems in realtime.

In this demo, employees organize containers on a production floor into groups. While employees do thier work, a 'monitor' app visualizes events and production state so a manager can watch in realtime.

The integration test suite simulates a simple production flow: A manager opens the monitoring app, an administrator sets up the production floor, and employees work until done. The tests interact with the system just like it were an actual production system - all the actions are behind out-of-process api's. It would be trivial, for example, to replace the 'employee' agent with a mobile application that hits the same end points.

## See it in action

**Play the video:** [synchrony.webm](https://raw.githubusercontent.com/thedeeno/synchrony/master/synchrony.webm) (right click, save as...)

## Or run it yourself

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

This sinatra app leverages 2 micro applications (`/api` and `/monitor`) and a faye messaging application (mounted at `/faye`) in a single rack instance. The **monitor** subscribes to events published by the **api** via messages sent by **faye**. 

The cucumber integration tests in `features` are the primary way to see this app in action.

