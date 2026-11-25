# Traffic Light API (M324, LU04e)

Traffic-light app with a REST API (Express), a Dockerfile and unit tests (jest + supertest) that run against the API.

## Structure

| Path | Content |
|---|---|
| `backend/` | Source code of the app: `index.js` (Express server, port 3000), `api.trafficlight.js` (routes), `trafficlight.js` (logic) |
| `Dockerfile` | Container image based on Node.js LTS (`node:24-slim`), exposes port 3000 |
| `trafficlight.test.js`, `package.json` | Unit tests over the REST API |
| `01_params.sh` … `06_scp.sh` | Scripts: parameters, build, run, install node, test, copy to EC2 |

## API

| Route | Answer |
|---|---|
| `GET /api/welcome` | `{"message":"Welcome to Traffic-Light!","status":"success"}` |
| `GET /api/trafficlight` | `{"message":"OUT OF ORDER","status":"success"}` |
| `GET /api/trafficlight/red` | `{"message":"DON'T WALK!","status":"success"}` |
| `GET /api/trafficlight/orange` | `{"message":"ATTENTION!","status":"success"}` |
| `GET /api/trafficlight/green` | `{"message":"WALK!","status":"success"}` |
| `GET /api/trafficlight/<other>` | HTTP 400, `{"message":"Unknown color '<other>'","status":"error"}` |

## Run on AWS EC2

```
./06_scp.sh <public-ip-of-ec2>   # local: copy everything to ~/03 on EC2
# on EC2:
cd ~/03
./02_setup.sh                    # build image traffic_img
./03_run.sh                      # run container traffic on port 3000
curl http://localhost:3000/api/welcome
./04_install-node.sh             # install node on the host (once)
./05_test-api.sh                 # npm install + npm test against the container
```

The tests use `http://localhost:3000` by default. Another address can be set with `API_URL`, e.g. `API_URL=http://1.2.3.4:3000 npm test`.
