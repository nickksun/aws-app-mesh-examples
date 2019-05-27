# Setup Grafana dashboard

> Ensure to run **update-targetgroups.sh** located at *examples/apps/colorapp/ecs*

> Double check the target group of *AppMeshSample-prometheus-1* and ensure the *Success codes* of *Health checks* are set to `200-499`.

Open http://ELB_PUBLIC_IP:3000

use default username/password: `admin` / `admin`

(Grafana will prompt for a new password, please set properly or click `skip`)

## Setup steps:

1. Click **Add data source**
2. Select **Prometheus**
3. In *URL* field, type in `http://colorgateway.default.svc.cluster.local:9090`
4. Click **Save & Test**, ensure to see "Data source is working"
5. From the very left panel, click the **+** icon then select **Import**, (if prompt "Do you want to save your changes?", click **Discard**)
6. Click **Upload .json File**
7. Locate path **examples/apps/colorapp/grafana** of the code base, and select **envoy_grafana.json**
8. Click **Import**

If return to the Grafana dashboard
1. Open http://ELB_PUBLIC_IP:3000/login
2. Login
3. If default `admin` / `admin` is used, Grafana will prompt for a new password, please set properly or click `skip`
4. Click **Home** at top of page
5. Click **Grafana** to open the dashboard
