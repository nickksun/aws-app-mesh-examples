# **Region must be `Sydney`**

## Check settings in App Mesh
From **AWS Console**, click `Services` from top menu, then search for "**App Mesh**"

Check how `Virtual Nodes`, `Virtual routers`, `Virtual routes` are defined.

![console-appmesh]

## Change the routes between Microservices

1. Start `Session Manager` via `Services` -> search for "**Systems Manager**"
2. Click on `Start session`
3. Locate `AppMeshSample-Bastion`
4. Select `AppMeshAmple-Bastion` then click `Start session`
5. Run the following command

```sh
for((i=0;i<10;i++)) do curl http://colorgateway.default.svc.cluster.local:9080/color && sleep 1 && echo ""; done;
```
Check the result and see values returned from `colorteller` service

Then use the following command to change the traffic to be **100%** returned from "*colorteller-white*"
```
aws appmesh update-route --mesh-name default --cli-input-json '{
    "routeName": "colorteller-route",
    "spec": {
        "httpRoute": {
            "action": {
                "weightedTargets": [
                    {
                        "virtualNode": "colorteller-white-vn",
                        "weight": 1
                    }
                ]
            },
            "match": {
                "prefix": "/"
            }
        }
    },
    "virtualRouterName": "colorteller-vr"
}' --region ap-southeast-2
```
Check the result:
```
for((i=0;i<10;i++)) do curl http://colorgateway.default.svc.cluster.local:9080/color && sleep 1 && echo ""; done;
```

Then use the following command to change the traffic to be **80%** returned from "*colorteller-black*" and **20%** returned from "*colorteller-blue*"
```
aws appmesh update-route --mesh-name default --cli-input-json '{
    "routeName": "colorteller-route",
    "spec": {
        "httpRoute": {
            "action": {
                "weightedTargets": [
                    {
                        "virtualNode": "colorteller-black-vn",
                        "weight": 8
                    },
                    {
                        "virtualNode": "colorteller-blue-vn",
                        "weight": 2
                    }
                ]
            },
            "match": {
                "prefix": "/"
            }
        }
    },
    "virtualRouterName": "colorteller-vr"
}' --region ap-southeast-2
```
Check the result:
```sh
for((i=0;i<10;i++)) do curl http://colorgateway.default.svc.cluster.local:9080/color && sleep 1 && echo ""; done;
```
----

## Monitor:
### X-Ray
1. Navigate to `AWS X-Ray` via `Services` -> search for **X-Ray**
2. Click on "Service map" from the left pane
3. Change filter to "**Last 15 minutes**" then click **refresh button** next to it

![console-x-ray]

Check the service map details

### Grafana


1. Navigate to `CloudFormation` via `Services` -> search for **Cloudformation**
2. Locate `AppMeshSample-ecs-cluster` stack
3. Locate **Output** tab and find "**ExternalUrl**"
4. Navigate to `ExternalUrl`
5. Open the following URL in the browser: `ExternalUrl:3000`
6. Login with admin/*PASSWORD*
7. **Open another browser window** and navigate to **Session Manager**
8. From **Session Manager**, run

```sh
for((i=0;i<10;i++)) do curl http://colorgateway.default.svc.cluster.local:9080/color && sleep 1 && echo ""; done;
```

Check the dashboard


[console-appmesh]:  ./resources/console-appmesh.png
[console-x-ray]:  ./resources/console-x-ray.png