consul-twilio.sh will be triggered by consul check scripts in case a service reaches critical state i.e. the service STOP responding.
Using this script, we are also going to leverage the consul key-value store for storing a list of critical states triggered for services in the production cloud. 

As a pre-requisite the following is required :

* Add the following key - folders 

```
consul kv put consul-alerts/config/notifiers/twilio/
consul kv put consul-alerts/config/notifiers/twilio/call-history/
```
Please note, the above 2 keys end with '/' indicating a folder 

* Add the following key-value from any consul node 

```
consul kv put consul-alerts/config/notifiers/twilio/devops-oncall-url "url to fetch devops on call numbers" 
Consul kv put consul-alerts/config/notifiers/twilio/from-number  "Twilio Number"
consul kv put consul-alerts/config/notifiers/twilio/proxy-url "http://<proxy in case behind firewall>:8678"
consul kv put consul-alerts/config/notifiers/twilio/user-key "<key provided by twilio website>"
consul kv put consul-alerts/config/notifiers/twilio/voice-xml "http://demo.twilio.com/docs/voice.xml"
consul kv put consul-alerts/config/notifiers/twilio/xpost-url "https://api.twilio.com/2010-04-01/Accounts/<key provided by twilio website>/Calls.json"
consul kv put consul-alerts/config/notifiers/twilio/devopsoncall-numbers "fix-number1 fix number2"
```
For devopsoncall-numbers, it is suggested to add them from consul dashboard using the key-value store in below format of one value per line and update the key.

```
fix-number1
fix-number2
fix-number3
```

* Place the new twilio script in /etc/consul.d/script/twilio-call/twilio.sh

* Please note - use /bin/bash to invoke the twilio script from any of the alert script.

